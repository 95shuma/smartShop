package com.shop.smart.repository;

import com.shop.smart.model.Basket;
import com.shop.smart.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BasketRepository extends JpaRepository<Basket,Integer> {

    Basket findBasketBySession(String session);

    Basket findBasketByUser(User user);

    Basket findBasketByUserAndSession(User user,String session);
}
