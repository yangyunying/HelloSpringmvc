package com.springmvc01.service;

import com.springmvc01.dao.IUserDAO;
import com.springmvc01.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**用户业务*/
@Service
public class UserService {

    //@Autowired
    //IUserDAO userdao;
    @Resource(name="mysql")
    IUserDAO userdao;


    public List<User> queryAllUsers(){
        return userdao.getAll();
    }

    public User getUserById(int id){
        return userdao.getUserById(id);
    }

    public boolean deleteUser(int id){
        return userdao.delete(id);
    }

    public  boolean addUser(User user){
        return userdao.add(user);
    }

    public boolean editUser(User user){
        return userdao.update(user);
    }

}