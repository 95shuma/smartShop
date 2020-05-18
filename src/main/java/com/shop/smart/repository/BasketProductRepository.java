package com.shop.smart.repository;

import com.shop.smart.model.Basket;
import com.shop.smart.model.BasketProduct;
import com.shop.smart.model.Product;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface BasketProductRepository  extends JpaRepository <BasketProduct,Integer> {

    BasketProduct findBasketProductByProductAndBasket(Product product, Basket basket);

    List<BasketProduct> findBasketProductByBasket(Basket basket);
}
