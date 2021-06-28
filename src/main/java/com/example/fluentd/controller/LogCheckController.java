package com.example.fluentd.controller;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.fluentd.logger.FluentLogger;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

@Slf4j
@RestController
@AllArgsConstructor
@RequestMapping("api/v1/log")
public class LogCheckController {

//    private static FluentLogger LOGGER = FluentLogger.getLogger("app");

    @GetMapping("/check")
    public ResponseEntity<String> check() {
//        Map<String, Object> data = new HashMap<>();
//        data.put("name", "Andy");
//        data.put("age", "21");
//        data.put("country", "America");
//
//        LOGGER.log("user", data);
        log.info("test message");

        try {
            throw new NullPointerException();
        } catch (Exception e) {
            log.error("Test error message", e);
        }

        return new ResponseEntity<>("Hello world", HttpStatus.OK);
    }
}
