resource "aws_launch_configuration" "this" {
  name                        = "${var.tags.system}-lc"
  image_id                    = data.aws_ami.amzn2_latest.id
  instance_type               = var.aws.instance_type
  key_name                    = var.aws.key_pair.name
  security_groups             = ["sg-0d4de02506a284507"]
  associate_public_ip_address = true
  root_block_device {
    volume_type = "gp2"
    volume_size = 30
  }
  user_data = file("./../../sh/ecs_cluster_init.sh")
}

resource "aws_autoscaling_group" "this" {
  name                 = "${var.tags.system}-asg"
  desired_capacity     = 0
  max_size             = 0
  min_size             = 0
  health_check_type    = "EC2"
  launch_configuration = aws_launch_configuration.this.name
  vpc_zone_identifier = [
    var.aws.subnet.public.az1.id,
    var.aws.subnet.public.az4.id
  ]
  tags = concat(
    [
      {
        key                 = "CreatedBy"
        value               = var.tags.CreatedBy
        propagate_at_launch = true
      },
      {
        key                 = "system"
        value               = var.tags.system
        propagate_at_launch = true
      }
    ]
  )
  //  health_check_grace_period = 300
}

resource "aws_lb_target_group" "blue" {
  name     = "${var.system}-blue"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.aws.vpc.id
  tags     = var.tags
}

resource "aws_lb_target_group" "green" {
  name     = "${var.system}-green"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.aws.vpc.id
  tags     = var.tags
}

resource "aws_lb" "this" {
  name               = "${var.tags.system}-lb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = ["sg-0df10fcebe1ae893a"]
  subnets = [
    var.aws.subnet.public.az1.id,
    var.aws.subnet.public.az4.id
  ]

  //  access_logs {
  //    bucket  = aws_s3_bucket.lb_logs.bucket
  //    prefix  = "test-lb"
  //    enabled = true
  //  }
  tags = var.tags
}

resource "aws_lb_listener" "blue" {
  load_balancer_arn = aws_lb.this.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.blue.arn
  }
}

resource "aws_lb_listener" "green" {
  load_balancer_arn = aws_lb.this.arn
  port              = "8080"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.green.arn
  }
}

resource "aws_ecs_cluster" "this" {
  name = local.cluster_name
  tags = var.tags

  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}

resource "aws_ecs_task_definition" "this" {
  family = "service"
  container_definitions = jsonencode([
    {
      name      = "first"
      image     = "service-first"
      cpu       = 10
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    },
    {
      name      = "second"
      image     = "service-second"
      cpu       = 10
      memory    = 256
      essential = true
      portMappings = [
        {
          containerPort = 443
          hostPort      = 443
        }
      ]
    }
  ])

  volume {
    name      = "service-storage"
    host_path = "/ecs/service-storage"
  }

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [us-west-2a, us-west-2b]"
  }
}

resource "aws_ecs_service" "this" {
  name            = "mongodb"
  cluster         = aws_ecs_cluster.foo.id
  task_definition = aws_ecs_task_definition.mongo.arn
  desired_count   = 3
  iam_role        = aws_iam_role.foo.arn
  depends_on      = [aws_iam_role_policy.foo]

  ordered_placement_strategy {
    type  = "binpack"
    field = "cpu"
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.foo.arn
    container_name   = "mongo"
    container_port   = 8080
  }

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [us-west-2a, us-west-2b]"
  }
}
