package com.shop.smart.model;

import lombok.*;

import javax.persistence.*;
import javax.validation.constraints.Positive;

@Data
@Builder
@AllArgsConstructor(access = AccessLevel.PACKAGE)
@NoArgsConstructor
@Entity
@Table(name = "baskets_products")
public class BasketProduct {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column
    @Positive
    @Builder.Default
    private Integer quantity = 1;

    @ManyToOne
    @JoinColumn(name = "baskets_id")
    private Basket basket;

    @ManyToOne
    @JoinColumn(name = "products_id")
    private Product product;

    public BasketProduct(Basket basket,Product product, Integer quantity){
        this.basket = basket;
        this.product = product;
        this.quantity = quantity;
    }
}
