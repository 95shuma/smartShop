package com.shop.smart.repository;

import com.shop.smart.model.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import java.util.List;

public interface ProductRepository extends JpaRepository<Product,Integer> {

    @Query("select p from Product as p where p.name like CONCAT(:name, '%')")
    List<Product> getByName(String name);
}
