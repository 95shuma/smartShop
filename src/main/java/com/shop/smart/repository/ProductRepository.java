package com.shop.smart.repository;

import com.shop.smart.model.Product;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import java.util.List;

public interface ProductRepository extends JpaRepository<Product,Integer> {

    Page<Product> findAll(Pageable page);

    @Query("select p from Product as p where p.name like CONCAT(:name, '%')")
    List<Product> getByName(String name);

    @Query("From Product as p where p.description like CONCAT(:description, '%')")
    List<Product> getByDescription(String description);

    @Query("from Product as p where p.id = :id")
    Product findProductById(Integer id);

    @Query("From Product where price<(:price)")
    List<Product> getByPrice(Float price);

    @Query("From Product where brand.id = :brand")
    List<Product> getByBrand(Integer brand);

    @Query("From Product where category.name like CONCAT(:name,'%') ")
    List<Product> getByCategory(String name);
}
