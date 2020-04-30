package com.shop.smart.model;

import lombok.*;

import javax.persistence.*;

@Data
@Builder
@AllArgsConstructor(access = AccessLevel.PACKAGE) @NoArgsConstructor
@Entity
@Table(name = "user")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(length = 45)
    private String name;

    @Column(length = 45)
    private String mail;

    @Column(length = 45)
    private String password;
}
