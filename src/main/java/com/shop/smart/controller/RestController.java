package com.shop.smart.controller;

import com.shop.smart.model.Brand;
import com.shop.smart.model.Category;
import com.shop.smart.model.Product;
import com.shop.smart.model.User;
import com.shop.smart.repository.BrandRepository;
import com.shop.smart.repository.CategoryRepository;
import com.shop.smart.repository.ProductRepository;
import com.shop.smart.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;
import java.util.List;

@Controller
public class RestController {
    @Autowired
    BrandRepository br;

    @Autowired
    CategoryRepository cr;

    @Autowired
    UserRepository ur;

    /*@GetMapping("/br")
    public List<Brand> getBr(){
        return br.findAll();
    }

    @GetMapping("/cr")
    public List<Category> getCr(){
        return cr.findAll();
    }*/

    @GetMapping("/registration")
    public String registrationPage(Model model){
        if (!model.containsAttribute("form")) {
            model.addAttribute("form", new User());
        }

        return "registration";
    }

    @PostMapping("/registration")
    public String createUser(@Valid User user, BindingResult br, RedirectAttributes ra
    ) {
        ra.addFlashAttribute("form", user);
        if (br.hasFieldErrors()){
            ra.addFlashAttribute("errors",br.getFieldErrors());
            return "redirect:/registration";
        }else {
            System.out.println(user);
            ur.save(user);
            return "redirect:/";
        }
    }

}
