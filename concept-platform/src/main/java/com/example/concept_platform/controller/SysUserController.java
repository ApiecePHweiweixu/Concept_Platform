package com.example.concept_platform.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.example.concept_platform.common.Result;
import com.example.concept_platform.entity.SysUser;
import com.example.concept_platform.service.ISysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequestMapping("/api/user")
public class SysUserController {

    @Autowired
    private ISysUserService sysUserService;

    @PostMapping("/login")
    public Result<SysUser> login(@RequestBody SysUser loginUser) {
        if (loginUser.getUsername() == null || loginUser.getPassword() == null) {
            return Result.error("Username and password are required");
        }
        
        SysUser user = sysUserService.login(loginUser.getUsername(), loginUser.getPassword());
        if (user != null) {
            return Result.success(user);
        } else {
            return Result.error("Invalid username or password");
        }
    }

    @PostMapping("/register")
    public Result<String> register(@RequestBody SysUser registerUser) {
        if (registerUser.getUsername() == null || registerUser.getPassword() == null || registerUser.getRealName() == null) {
            return Result.error("Username, password and real name are required");
        }

        // Check if username exists
        QueryWrapper<SysUser> query = new QueryWrapper<>();
        query.eq("username", registerUser.getUsername());
        if (sysUserService.count(query) > 0) {
            return Result.error("用户名已存在");
        }

        // Set default values
        registerUser.setRole("APPLICANT"); // Only allow APPLICANT registration
        registerUser.setCreatedAt(LocalDateTime.now());
        
        // Save
        boolean success = sysUserService.save(registerUser);
        if (success) {
            return Result.success("Register success");
        } else {
            return Result.error("Register failed");
        }
    }

    @GetMapping("/experts")
    public Result<List<SysUser>> getExperts() {
        QueryWrapper<SysUser> query = new QueryWrapper<>();
        query.eq("role", "EXPERT");
        List<SysUser> list = sysUserService.list(query);
        // Hide passwords
        list.forEach(u -> u.setPassword(null));
        return Result.success(list);
    }
}
