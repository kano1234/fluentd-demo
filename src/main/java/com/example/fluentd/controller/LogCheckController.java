package com.example.fluentd.controller;

import com.example.fluentd.service.LogCheckService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@AllArgsConstructor
@RequestMapping("api/v1/log")
public class LogCheckController {

    private final LogCheckService logCheckService;

    @GetMapping("/check")
    public ResponseEntity<String> check() {
        log.info("Check info message");
        return new ResponseEntity<>("Success", HttpStatus.OK);
    }

    @GetMapping("/check/{id}")
    public ResponseEntity<String> checkId(@PathVariable("id") int id) {
        return new ResponseEntity<>(logCheckService.findById(id), HttpStatus.OK);
    }

    @GetMapping("/check/exception")
    public ResponseEntity<String> exception() {
        try {
            throw new NullPointerException();
        } catch (Exception e) {
            log.error("Check error message", e);
        }
        return new ResponseEntity<>("Internal server error", HttpStatus.INTERNAL_SERVER_ERROR);
    }

}
