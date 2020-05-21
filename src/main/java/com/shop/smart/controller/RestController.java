package com.shop.smart.controller;

import com.shop.smart.model.*;
import com.shop.smart.repository.*;
import com.shop.smart.service.PropertiesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.security.Principal;
import java.util.List;

@org.springframework.web.bind.annotation.RestController
public class RestController {

    private final PropertiesService propertiesService;

    @Autowired
    ProductRepository pr;

    @Autowired
    BasketRepository basketRepository;

    @Autowired
    BasketProductRepository basketProductRepository;

    @Autowired
    UserRepository ur;

    @Autowired
    ReviewRepository rr;

    public RestController(PropertiesService propertiesService) {
        this.propertiesService = propertiesService;
    }

//    @RequestMapping("/products")
//    public Page<Product> getProducts(Pageable page){
//
//        return pr.findAll(page);
//    }

    private static <T> void constructPageable(Page<T> list, int pageSize, Model model, String uri) {
        if (list.hasNext()) {
            model.addAttribute("nextPageLink", constructPageUri(uri, list.nextPageable().getPageNumber(), list.nextPageable().getPageSize()));
        }

        if (list.hasPrevious()) {
            model.addAttribute("prevPageLink", constructPageUri(uri, list.previousPageable().getPageNumber(), list.previousPageable().getPageSize()));
        }

        model.addAttribute("hasNext", list.hasNext());
        model.addAttribute("hasPrev", list.hasPrevious());
        model.addAttribute("items", list.getContent());
        model.addAttribute("defaultPageSize", pageSize);
    }

    private static String constructPageUri(String uri, int page, int size) {
        return String.format("%s?page=%s&size=%s", uri, page, size);
    }

    //69
    @PostMapping("/products/basket/addInBasket")
    public Product addInBasket(@RequestParam("id") Integer id, HttpSession session){
        var product = pr.findProductById(id);
        Basket basket = basketRepository.findBasketBySession(session.getId());
        if(basketProductRepository.findBasketProductByProductAndBasket(product,basket)==null){
            BasketProduct basketProduct = new BasketProduct(basket,product,1);
            basketProductRepository.save(basketProduct);
        } else {
            BasketProduct basketProduct = basketProductRepository.findBasketProductByProductAndBasket(product, basket);
            basketProductRepository.delete(basketProduct);
        }
        return product;
    }

    @PostMapping("/products/basket/addInBasket/minus")
    public Product addInBasketMinus(@RequestParam("id") Integer id, HttpSession session){
        var product = pr.findProductById(id);
        Basket basket = basketRepository.findBasketBySession(session.getId());
        BasketProduct basketProduct = basketProductRepository.findBasketProductByProductAndBasket(product, basket);
        if (basketProduct.getQuantity()>1){
            basketProduct.setQuantity(basketProduct.getQuantity()-1);
            basketProductRepository.save(basketProduct);
        } else {
            basketProductRepository.delete(basketProduct);
        }
        return product;
    }

    @PostMapping("/products/basket/addInBasket/plus")
    public Product addInBasketPlus(@RequestParam("id") Integer id, HttpSession session){
        var product = pr.findProductById(id);
        Basket basket = basketRepository.findBasketBySession(session.getId());
        if(basketProductRepository.findBasketProductByProductAndBasket(product,basket)==null){
            BasketProduct basketProduct = new BasketProduct(basket,product,1);
            basketProductRepository.save(basketProduct);
        } else {
            BasketProduct basketProduct = basketProductRepository.findBasketProductByProductAndBasket(product, basket);
            basketProduct.setQuantity(basketProduct.getQuantity()+1);
            basketProductRepository.save(basketProduct);
        }
        return product;
    }
//    @GetMapping("/products")
//    public List<Product> getProducts(Principal principal, HttpSession session){
//        var user = ur.findUserByMail(principal.getName());
//        var basket = new Basket(user,session.getId());
//        basketRepository.save(basket);
//        return pr.findAll();
//    }

    @PostMapping("/products/review/addReview")
    public Review addReview(@RequestParam("review") String text, @RequestParam("id") Integer id, Principal principal){
        Review review = Review.builder()
                .text(text)
                .user(ur.findUserByMail(principal.getName()))
                .product(pr.findProductById(id))
                .build();
        rr.save(review);
        return review;
    }

    @PostMapping("/user/lang")
    public User userLang(@RequestParam("lang") String lang, Principal principal){
        User user=ur.findUserByMail(principal.getName());
        user.setLang(lang);
        ur.save(user);
        return user;
    }
}
