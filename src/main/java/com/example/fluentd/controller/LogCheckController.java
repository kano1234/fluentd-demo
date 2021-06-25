package com.example.fluentd.controller;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.fluentd.logger.FluentLogger;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@AllArgsConstructor
@RequestMapping("api/v1/log")
public class LogCheckController {

    private static FluentLogger LOG = FluentLogger.getLogger("fluentd.test");

    @GetMapping("/check")
    public ResponseEntity<String> check() {
        LOG.log("spring", "test", "Hello world");
        return new ResponseEntity<>("Hello world", HttpStatus.OK);
    }
}
