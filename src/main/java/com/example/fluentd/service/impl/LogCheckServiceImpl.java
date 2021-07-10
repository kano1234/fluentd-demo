package com.example.fluentd.service.impl;

import com.example.fluentd.service.LogCheckService;
import com.example.fluentd.service.client.SecondAppClient;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@AllArgsConstructor
public class LogCheckServiceImpl implements LogCheckService {

    private final SecondAppClient client;

    @Override
    public String findById(int id) {
        return client.findById(id);
    }

}
