package com.shop.smart.model;

import lombok.*;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Data @Builder
@AllArgsConstructor(access = AccessLevel.PACKAGE)
@NoArgsConstructor
@Entity
@Table(name = "brands")

public class Brand {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(length = 45)
    private String name;

    @Column(length = 45)
    private String img;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "brand") @OrderBy("name ASC")
    private List<Product> products;

    public List<Product> getProducts() {
        return new ArrayList<>();
    }
}
