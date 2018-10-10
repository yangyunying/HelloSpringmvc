package com.ajaxForRestful.controller;

import com.springmvc01.entity.User;
import com.springmvc01.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * AJAX客户端调用RESTful
 */
@RestController
@RequestMapping(path = "/ajaxEmps")
public class AjaxEmpController{

    @Autowired
    UserService userService;

    @RequestMapping(path = "", method = RequestMethod.GET)
    public AjaxState getAllEmps() {
        List<User> users=userService.queryAllUsers();
        boolean result=users!=null;
        return new AjaxState(result?"success":"error",users,result?"获得数据成功！":"获得数据失败!");
    }

    @RequestMapping(path = "/{id}", method = RequestMethod.GET)
    public AjaxState getEmpById(@PathVariable int id) {
        User user=userService.getUserById(id);
        boolean result=user!=null;
        return new AjaxState(result?"success":"error",user,result?"获得数据成功！":"获得数据失败!");
    }

    @RequestMapping(path = "", method = RequestMethod.POST)
    public AjaxState addEmp(@RequestBody User user) {
        boolean result=userService.addUser(user);
        return new AjaxState(result?"success":"error",user,result?"添加成功！":"添加失败");
    }

    @RequestMapping(path = "", method = RequestMethod.PUT)
    public AjaxState updateEmp(@RequestBody User user) {
        boolean result=userService.editUser(user);
        return new AjaxState(result?"success":"error",user,result?"修改成功！":"修改失败");
    }

    @RequestMapping(path = "/{id}", method = RequestMethod.DELETE)
    public AjaxState deleteEmpById(@PathVariable int id) {
        Boolean result=userService.deleteUser(id);
        return new AjaxState(result?"success":"error",id,result?"删除成功！":"删除失败");
    }

}

class  AjaxState{
    public String state;
    public Object data;
    public String message;

    public AjaxState(String state, Object data, String message) {
        this.state = state;
        this.data = data;
        this.message = message;
    }

    public AjaxState(){}
}
