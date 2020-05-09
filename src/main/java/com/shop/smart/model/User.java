package com.shop.smart.model;

import lombok.*;

import javax.persistence.*;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

@Data
@Builder
@AllArgsConstructor(access = AccessLevel.PACKAGE) @NoArgsConstructor
@Entity
@Table(name = "users")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @NotBlank(message = "Поле не должно быть пустым")
    @Size(min=5, max = 45,message = "Имя не должно быть меньше 5 и не больше 45 символов")
    @Column(length = 45)
    private String name;

    //@NotBlank(message = "Поле не должно быть пустым")
    @Size(min=5, max = 45,message = "Почта не должна быть меньше 5 и не больше 45 символов")
    @Email
    @Column(length = 45)
    private String mail;

    @NotBlank(message = "Поле не должно быть пустым")
    @Size(min=5, max = 45,message = "Логин не должен быть меньше 5 и не больше 45 символов")
    @Column(length = 45)
    private String login;

    @NotBlank(message = "Поле не должно быть пустым")
    @Size(min=5, max = 128,message = "Пароль не должен быть меньше 5 и не больше 128 символов")
    @Column(length = 45)
    private String password;

    @Column
    @Builder.Default
    private boolean enabled = true;

    @NotBlank
    @Size(min = 1, max = 128)
    @Column(length = 128)
    @Builder.Default
    private String role = "USER";
}
