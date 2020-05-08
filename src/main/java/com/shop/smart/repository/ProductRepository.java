package com.shop.smart.repository;

import com.shop.smart.model.Product;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import java.util.List;

public interface ProductRepository extends JpaRepository<Product,Integer> {

    Page<Product> findAll(Pageable page);

    @Query("select p from Product as p where (p.name like CONCAT(:name, '%')) or (p.name like CONCAT('%',:name, '%')) or (p.name like CONCAT('%',:name))")
    Page<Product> findProductByName(String name, Pageable page);

    @Query("From Product as p where (p.description like CONCAT(:description, '%')) or (p.description like CONCAT('%',:description, '%')) or (p.description like CONCAT('%',:description))")
    Page<Product> findProductByDescription(String description, Pageable page);

    @Query("from Product as p where p.id = :id")
    Product findProductById(Integer id);

    @Query("From Product as p where p.price<(:price)")
    Page<Product> findProductByPrice(Float price, Pageable page);

//    @Query("From Product where brand.id = :brand")
//    Page<Product> getByBrand(Integer brand, Pageable page);
    //@Query("From Product where brand.id = :brand")
    Page<Product> findProductByBrand_Id(Integer brand, Pageable page);

    //@Query("From Product where category.name = :name ")
    Page<Product> findProductByCategory_Name(String name, Pageable page);
}
