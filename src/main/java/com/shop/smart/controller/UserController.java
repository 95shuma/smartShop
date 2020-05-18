package com.shop.smart.controller;

import com.shop.smart.model.PasswordResetToken;
import com.shop.smart.model.User;
import com.shop.smart.repository.ResetRepository;
import com.shop.smart.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.UUID;

@Controller
public class UserController {
    private final PasswordEncoder encoder;

    @Autowired
    UserRepository ur;

    @Autowired
    ResetRepository resetRepo;

    public UserController(PasswordEncoder encoder) {
        this.encoder = encoder;
    }

    @RequestMapping("/forgot-password")
    public String pageForgotPassword(Model model) {
        return "forgot";
    }

    @PostMapping("/forgot-password")
    public String submitForgotPasswordPage(@RequestParam("email") String email,
                                           RedirectAttributes attributes) {

        if (!ur.existsUserByMail(email)) {
            attributes.addFlashAttribute("errorText", "Entered email does not exist!");
            return "redirect:/forgot-password";
        }
        PasswordResetToken pToken = PasswordResetToken.builder()
                .user(ur.findUserByMail(email))
                .token(UUID.randomUUID().toString())
                .build();
        System.out.println(pToken);
        //resetRepo.deleteAll();
        resetRepo.save(pToken);

        return "redirect:/forgot-success";
    }

    @RequestMapping("/forgot-success")
    public String pageResetPassword(Model model) {
        return "forgot-success";
    }

    @PostMapping("/reset-password")
    public String submitResetPasswordPage(@RequestParam("token") String token,
                                          @RequestParam("newPassword") String newPassword,
                                          RedirectAttributes attributes) {

        if (!resetRepo.existsByToken(token)) {
            attributes.addFlashAttribute("errorText", "Entered token does not exist!");
            return "redirect:/reset-password";
        }
        PasswordResetToken pToken = resetRepo.findByToken(token);
        User user = pToken.getUser();
        user.setPassword(encoder.encode(newPassword));

        ur.save(user);

        return "redirect:/login";
    }
}
