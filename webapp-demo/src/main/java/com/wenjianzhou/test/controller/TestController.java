package com.wenjianzhou.test.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.logging.Level;
import java.util.logging.Logger;


@Controller()
public class TestController {

    @RequestMapping(value = "/test", produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String test(HttpServletRequest request, HttpServletResponse response) {


        Logger.getLogger(TestController.class.getName()).log(Level.INFO, "test");

        return "{\"test'\":\"aaa\"}";
    }

}