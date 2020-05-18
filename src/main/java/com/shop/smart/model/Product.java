package com.shop.smart.model;

import lombok.*;

import javax.persistence.*;
import javax.validation.constraints.Positive;
import java.util.ArrayList;
import java.util.List;

@Data @Builder
@AllArgsConstructor(access = AccessLevel.PACKAGE) @NoArgsConstructor
@Entity
@Table(name = "products")
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(length = 45)
    private String name;

    @Column(length = 45)
    private String description;

    @Column(length = 45)
    private String img;

    @Column
    @Positive
    private Float price;

    @ManyToOne
    @JoinColumn(name = "categories_id")
    private Category category;

    @ManyToOne
    @JoinColumn(name = "brands_id")
    private Brand brand;

    @OneToMany(mappedBy = "product")
    private List<BasketProduct> basket;

    public List<BasketProduct> getBasket() {
        return new ArrayList<>();
    }
}
