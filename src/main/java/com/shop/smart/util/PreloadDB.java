package com.shop.smart.util;

import com.shop.smart.model.User;
import com.shop.smart.repository.BasketProductRepository;
import com.shop.smart.repository.BasketRepository;
import com.shop.smart.repository.UserRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.password.PasswordEncoder;

@Configuration
public class PreloadDB {
    private final PasswordEncoder encoder;

    public PreloadDB(PasswordEncoder encoder) {
        this.encoder = encoder;
    }

    @Bean
    CommandLineRunner initDatabase(UserRepository ur, BasketRepository basketRepository,
                                   BasketProductRepository bpr){
        return (args) -> {
            ur.deleteAll();
            basketRepository.deleteAll();
            bpr.deleteAll();
            User user = new User();
            user.setMail("admin@a.r");
            user.setName("admin");
            user.setLogin("admin");
            user.setPassword(encoder.encode("admin"));
            ur.save(user);
        };
    }
}
