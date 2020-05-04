package com.shop.smart.repository;

import com.shop.smart.model.Category;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface CategoryRepository extends JpaRepository<Category,Integer> {
    @Query("select p from Category as p where p.name like CONCAT(:name, '%')")
    List<Category> getByName(String name);
}
