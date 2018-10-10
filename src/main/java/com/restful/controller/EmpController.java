package com.restful.controller;

import com.springmvc01.entity.User;
import com.springmvc01.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 *
 * /emps  get 获得所有的员工信息

 /emps/1 get 获得编号为1的员工信息

 /emps post 添加

 /emps put 修改

 /emps/1 delete 删除

 */
@RestController
@RequestMapping(path = "/emps")
public class EmpController {

    @Autowired
    UserService userService;

    //获得所有的员工信息服务
    @RequestMapping(path = "", method = RequestMethod.GET)
    public List<User> getAllemps() {
        return userService.queryAllUsers();
    }

    //获得编号为id的员工信息
    @RequestMapping(path = "/{id}", method = RequestMethod.GET)
    public User getEmpById(@PathVariable int id) {
        return userService.getUserById(id);
    }

    //新增员工服务
    @RequestMapping(path = "", method = RequestMethod.POST,consumes="application/json;charset=utf-8")
    public boolean addEmp(@RequestBody User user) {
        return userService.addUser(user);
    }

    //修改员工服务
    @RequestMapping(path = "", method = RequestMethod.PUT,consumes="application/json;charset=utf-8")
    public boolean updateEmp(@RequestBody User user) {
        return userService.editUser(user);
    }

    //删除员工服务
    @RequestMapping(path = "/{id}", method = RequestMethod.DELETE)
    public AjaxState deleteEmpById(@PathVariable int id) {
        Boolean result=userService.deleteUser(id);
        return new AjaxState(result?"success":"error",id,result?"删除成功！":"删除失败");
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
}