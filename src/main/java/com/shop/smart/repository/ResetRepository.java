package com.shop.smart.repository;

import com.shop.smart.model.PasswordResetToken;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface ResetRepository extends JpaRepository<PasswordResetToken, Integer> {

    boolean existsByToken(String token);

    void deleteAll();

    PasswordResetToken findByToken(String token);
}
