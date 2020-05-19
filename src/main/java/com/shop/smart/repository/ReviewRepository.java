package com.shop.smart.repository;

import com.shop.smart.model.Review;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ReviewRepository extends JpaRepository<Review,Integer> {
    List<Review> findAllByProduct_Id(Integer id);
}
