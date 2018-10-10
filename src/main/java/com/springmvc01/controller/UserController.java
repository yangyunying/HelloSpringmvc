package com.springmvc01.controller;

import com.springmvc01.entity.User;
import com.springmvc01.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller  //声明为控制器
@RequestMapping(path = "/user")  //请求映射
public class UserController {

    @Autowired
    UserService userService;

	@RequestMapping(path = "/index")  //请求映射
    public String index(Model model){
        model.addAttribute("list",userService.queryAllUsers());
        return "user/index";
    }

    @RequestMapping("/delete/{id}")
    public String delete(@PathVariable int id){
        userService.deleteUser(id);
        return "redirect:/user/index";
    }

    @RequestMapping("/add")
    public String add(){
        return "user/add";
    }

    //@RequestMapping(value = "/add",method = RequestMethod.POST)
    @RequestMapping(value = "/addToIndex")
    public String add(User user){
    	userService.addUser(user);
        return "redirect:/user/index";
    }

    @RequestMapping("/edit/{id}")
    public String edit(@PathVariable int id,Model model){
        model.addAttribute("user",userService.getUserById(id));
        return "user/edit";
    }

    //@RequestMapping(value = "/edit",method = RequestMethod.POST)
    @RequestMapping(value = "/edit")
    public String edit(User user){
        userService.editUser(user);
        return "redirect:/user/index";
    }

}