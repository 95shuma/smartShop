package com.shop.smart.controller;

import com.shop.smart.model.User;
import com.shop.smart.repository.BrandRepository;
import com.shop.smart.repository.CategoryRepository;
import com.shop.smart.repository.ProductRepository;
import com.shop.smart.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;

@Controller

public class MainController {

    @Autowired
    BrandRepository br;

    @Autowired
    UserRepository ur;

    @Autowired
    CategoryRepository cr;

    @RequestMapping("/")
    public String mainPage(Model model){
        model.addAttribute("brands",br.findAll());
        model.addAttribute("categories",cr.findAll());
        return "index";
    }

    @RequestMapping("/{name}")
    public String mainPage1(Model model, @PathVariable("name") String name){
        model.addAttribute("brands", br.getByName(name));
        model.addAttribute("categories",cr.getByName(name));
        return "index";
    }

    @GetMapping("/login")
    public String loginPage(){
        return "login";
    }



}
