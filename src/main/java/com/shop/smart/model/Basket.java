package com.shop.smart.model;

import lombok.*;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

@Data
@Builder
@AllArgsConstructor(access = AccessLevel.PACKAGE)
@NoArgsConstructor
@Entity
@Table(name = "baskets")
public class Basket {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column
    private String session;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "users_id", referencedColumnName = "id")
    private User user;

    @OneToMany(mappedBy = "basket")
    private List<BasketProduct> products;

    public Basket(User user, String session){
        this.user = user;
        this.session = session;
    }

    public Basket(String session){
        this.session = session;
    }

    public List<BasketProduct> getProducts() {
        return new ArrayList<>();
    }
}
