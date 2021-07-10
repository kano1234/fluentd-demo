package com.example.fluentd.service.client;

import lombok.AllArgsConstructor;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

@Component
@AllArgsConstructor
public class SecondAppClient {

    public String findById(int id) {
        return new RestTemplate().getForObject("", String.class, id);
    }

}
