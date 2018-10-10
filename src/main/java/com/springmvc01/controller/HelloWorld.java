package com.springmvc01.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
/**
 * Created by admin on 2018/9/27.
 * 创建HelloWorld控制器
 */

@Controller  //声明为控制器
//@RequestMapping(path = "/home")  //请求映射
public class HelloWorld {
    /*@RequestMapping(path = "/index")  //请求映射
    public String index(Model model){
        model.addAttribute("message","Hello Spring MVC!");
        return "home/index";
    }*/
    
    String message = "Welcome to Spring MVC!";
    @RequestMapping("/home")
    public ModelAndView showMessage(@RequestParam(value = "name", required = false, defaultValue = "Spring") String name) {
    	 ModelAndView mv = new ModelAndView("home/index");//指定视图
	     mv.addObject("message", message);//向视图中添加所要展示或使用的内容，将在页面中使用
	     mv.addObject("name", name);
	     return mv;
    }
}