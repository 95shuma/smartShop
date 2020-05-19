package com.shop.smart.controller;

import com.shop.smart.model.*;
import com.shop.smart.repository.*;
import com.shop.smart.service.PropertiesService;
import com.shop.smart.exception.ResourceNotFoundException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.security.Principal;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Controller
public class MainController {

    @Autowired
    BrandRepository br;

    @Autowired
    UserRepository ur;

    @Autowired
    CategoryRepository cr;

    @Autowired
    ProductRepository pr;

    @Autowired
    BasketRepository basketRepository;

    @Autowired
    BasketProductRepository basketProductRepository;

    @Autowired
    ResetRepository resetRepo;

    @Autowired
    ReviewRepository rr;

    private final PropertiesService propertiesService;
    private final PasswordEncoder encoder;

    public MainController(PropertiesService propertiesService, PasswordEncoder encoder) {
        this.propertiesService = propertiesService;
        this.encoder = encoder;
    }

    private static <T> void constructPageable(Page<T> list, int pageSize, Model model, String uri) {
        if (list.hasNext()) {
            model.addAttribute("nextPageLink", constructPageUri(uri, list.nextPageable().getPageNumber(), list.nextPageable().getPageSize()));
        }

        if (list.hasPrevious()) {
            model.addAttribute("prevPageLink", constructPageUri(uri, list.previousPageable().getPageNumber(), list.previousPageable().getPageSize()));
        }

        model.addAttribute("hasNext", list.hasNext());
        model.addAttribute("hasPrev", list.hasPrevious());
        model.addAttribute("products", list.getContent());
        model.addAttribute("defaultPageSize", pageSize);
    }

    private static String constructPageUri(String uri, int page, int size) {
        return String.format("%s&page=%s&size=%s", uri, page, size);
    }

    private static <T> void constructPageable1(Page<T> list, int pageSize, Model model, String uri) {
        if (list.hasNext()) {
            model.addAttribute("nextPageLink", constructPageUri1(uri, list.nextPageable().getPageNumber(), list.nextPageable().getPageSize()));
        }

        if (list.hasPrevious()) {
            model.addAttribute("prevPageLink", constructPageUri1(uri, list.previousPageable().getPageNumber(), list.previousPageable().getPageSize()));
        }

        model.addAttribute("hasNext", list.hasNext());
        model.addAttribute("hasPrev", list.hasPrevious());
        model.addAttribute("products", list.getContent());
        model.addAttribute("defaultPageSize", pageSize);
    }

    private static String constructPageUri1(String uri, int page, int size) {
        return String.format("%s?page=%s&size=%s", uri, page, size);
    }

    @RequestMapping("/")
    public String mainPage(Model model, Principal principal){
        model.addAttribute("brands",br.findAll());
        model.addAttribute("categories",cr.findAll());
        try{
            var user = ur.findUserByMail(principal.getName());
            model.addAttribute("user",user);
        }catch (NullPointerException e){
            model.addAttribute("nouser",true);
        }
        return "index";
    }

    @GetMapping("/basket/clear")
    public String clearBasket(){
        basketRepository.deleteAll();
        return "redirect:/products";
    }

    @RequestMapping("/products")
    public String getProducts(Model model, Pageable page, HttpServletRequest uriBuilder, Principal principal, HttpSession session){
        var uri = uriBuilder.getRequestURI();
        constructPageable1(pr.findAll(page), propertiesService.getDefaultPageSize(), model,uri);
        if(basketRepository.findBasketBySession(session.getId())==null){
            try {
                var user = ur.findUserByMail(principal.getName());
                var basket = new Basket(user, session.getId());
                basketRepository.save(basket);
                model.addAttribute("authorization",1);
            }catch(NullPointerException e){
                var basket = new Basket(session.getId());
                basketRepository.save(basket);
                model.addAttribute("authorization",0);
            }
        }
        return "products";
    }

    @RequestMapping("/products/name")
    public String getProductByName(Model model, @RequestParam("name") String name,  Pageable page, HttpServletRequest uriBuilder, Principal principal){
        var uri = uriBuilder.getRequestURI().concat("?name=")+name;
        if (pr.findProductByName(name,page).getContent().get(0)==null)
            model.addAttribute("notFound",true);
        else
            constructPageable(pr.findProductByName(name,page), propertiesService.getDefaultPageSize(), model,uri);
        try{
            var user = ur.findUserByMail(principal.getName());
            model.addAttribute("authorization",1);
        }catch (NullPointerException e){
            model.addAttribute("authorization",0);
        }
        return "products";
    }

    @RequestMapping("/products/description")
    public String getProductByDescription(Model model, @RequestParam("description") String description, Pageable page, HttpServletRequest uriBuilder, Principal principal){
        var uri = uriBuilder.getRequestURI().concat("?description=")+description;
        constructPageable(pr.findProductByDescription(description,page), propertiesService.getDefaultPageSize(), model,uri);
        try{
            var user = ur.findUserByMail(principal.getName());
            model.addAttribute("authorization",1);
        }catch (NullPointerException e){
            model.addAttribute("authorization",0);
        }
        return "products";
    }

    @RequestMapping("/products/brand")
    public String getProductByBrand(Model model, @RequestParam("brand") Integer brand, Pageable page, HttpServletRequest uriBuilder, Principal principal){
        //model.addAttribute("products",pr.getByBrand(brand, page));
        var uri = uriBuilder.getRequestURI().concat("?brand=")+brand;
        constructPageable(pr.findProductByBrand_Id(brand, page), propertiesService.getDefaultPageSize(), model,uri);
        try{
            var user = ur.findUserByMail(principal.getName());
            model.addAttribute("authorization",1);
        }catch (NullPointerException e){
            model.addAttribute("authorization",0);
        }
        return "products";
    }

    @RequestMapping("/products/price")
    public String getProductByPrice(Model model, @RequestParam("price") Float price, Pageable page, HttpServletRequest uriBuilder, Principal principal){
        var uri = uriBuilder.getRequestURI().concat("?price=")+price;
        constructPageable(pr.findProductByPrice(price, page), propertiesService.getDefaultPageSize(), model,uri);
        try{
            var user = ur.findUserByMail(principal.getName());
            model.addAttribute("authorization",1);
        }catch (NullPointerException e){
            model.addAttribute("authorization",0);
        }
        return "products";
    }

    @RequestMapping("/products/category")
    public String getProductByCategory(Model model, @RequestParam("category") String category, Pageable page, HttpServletRequest uriBuilder, Principal principal){
        var uri = uriBuilder.getRequestURI().concat("?category=")+category;
        constructPageable(pr.findProductByCategory_Name(category, page), propertiesService.getDefaultPageSize(), model,uri);
        try{
            var user = ur.findUserByMail(principal.getName());
            model.addAttribute("authorization",1);
        }catch (NullPointerException e){
            model.addAttribute("authorization",0);
        }
        return "products";
    }

    @RequestMapping("/products/{id}")
    public String getProduct(Model model, @PathVariable("id") Integer id){
        model.addAttribute("product",pr.findProductById(id));
        if (rr.findAllByProduct_Id(id)==null){
            model.addAttribute("error","No reviews");
        } else {
            model.addAttribute("reviews",rr.findAllByProduct_Id(id));
        }
        return "product";
    }

    @RequestMapping("/{name}")
    public String mainPage1(Model model, @PathVariable("name") String name){
        model.addAttribute("brands", br.getByName(name));
        model.addAttribute("categories",cr.getByName(name));
        model.addAttribute("products",pr.findAll());
        return "index";
    }

    @GetMapping("/registration")
    public String registrationPage(Model model){
        if (!model.containsAttribute("form")) {
            model.addAttribute("form", new User());
        }

        return "registration";
    }

    @GetMapping("/login")
    public String loginPage(@RequestParam(required = false, defaultValue = "false") Boolean error, Model model) {
        model.addAttribute("error", error);
        return "login";
    }

    @PostMapping("/registration")
    public String createUser(@Valid User user, BindingResult br, RedirectAttributes ra
    ) {
        ra.addFlashAttribute("form", user);
        if (br.hasFieldErrors()){
            ra.addFlashAttribute("errors",br.getFieldErrors());
            return "redirect:/registration";
        }else {
            System.out.println(user);
            user.setPassword(encoder.encode(user.getPassword()));
            ur.save(user);
            return "redirect:/login";
        }
    }

    @GetMapping("/profile")
    public String pageCustomerProfile(Model model, Principal principal)
    {
        try {
            var user = ur.findUserByMail(principal.getName());
            model.addAttribute("dto", user);
        }
        catch (NullPointerException e){
            model.addAttribute("error", "Пользователь не найден!");
        }
        return "profile";
    }

    @ExceptionHandler(ResourceNotFoundException.class)
    @ResponseStatus(HttpStatus.UNPROCESSABLE_ENTITY)
    private String handleRNF(ResourceNotFoundException ex, Model model) {
        model.addAttribute("resource", ex.getResource());
        model.addAttribute("id", ex.getId());
        return "resource-not-found";
    }

    @RequestMapping("products/basket")
    public String getBasket(Model model, Principal principal, HttpSession session){
        var user = ur.findUserByMail(principal.getName());
        model.addAttribute("user",user);
        var basket = basketRepository.findBasketByUserAndSession(user, session.getId());
        if (basketProductRepository.findBasketProductByBasket(basket) == null) {
            model.addAttribute("error", "No element");
        } else {
            List<BasketProduct> bpr = basketProductRepository.findBasketProductByBasket(basket);
            model.addAttribute("products", bpr);
        }
        return "basket";
    }

    @RequestMapping("products/order")
    public String getOrder(Model model, Principal principal, HttpSession session){
        var user = ur.findUserByMail(principal.getName());
        model.addAttribute("user",user);
        var basket = basketRepository.findBasketByUserAndSession(user,session.getId());
        if(basketProductRepository.findBasketProductByBasket(basket)==null){
            model.addAttribute("error","No element");
        } else {
            List<BasketProduct> bpr = basketProductRepository.findBasketProductByBasket(basket);
            model.addAttribute("products",bpr);
            try{
                float sum = 0;
                for (BasketProduct bp:bpr) {
                    sum+=(bp.getQuantity()*bp.getProduct().getPrice());
                }
                model.addAttribute("totalSum",sum);
            } catch (Exception e){
                model.addAttribute("errors","Null");
            }

        }
        return "order";
    }


}
