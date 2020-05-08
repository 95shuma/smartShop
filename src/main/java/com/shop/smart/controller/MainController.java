package com.shop.smart.controller;

import com.shop.smart.PropertiesService;
import com.shop.smart.exception.ResourceNotFoundException;
import com.shop.smart.model.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import com.shop.smart.repository.BrandRepository;
import com.shop.smart.repository.CategoryRepository;
import com.shop.smart.repository.ProductRepository;
import com.shop.smart.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.repository.Query;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

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

    private final PropertiesService propertiesService;

    public MainController(PropertiesService propertiesService) {
        this.propertiesService = propertiesService;
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
    public String mainPage(Model model){
        model.addAttribute("brands",br.findAll());
        model.addAttribute("categories",cr.findAll());
        return "index";
    }

    @RequestMapping("/products")
    public String getProducts(Model model, Pageable page, HttpServletRequest uriBuilder){
        var uri = uriBuilder.getRequestURI();
        constructPageable1(pr.findAll(page), propertiesService.getDefaultPageSize(), model,uri);
        return "products";
    }

    @RequestMapping("/products/name")
    public String getProductByName(Model model, @RequestParam("name") String name,  Pageable page, HttpServletRequest uriBuilder){
        var uri = uriBuilder.getRequestURI().concat("?name=")+name;
        constructPageable(pr.findProductByName(name,page), propertiesService.getDefaultPageSize(), model,uri);
        return "products";
    }

    @RequestMapping("/products/description")
    public String getProductByDescription(Model model, @RequestParam("description") String description, Pageable page, HttpServletRequest uriBuilder){
        var uri = uriBuilder.getRequestURI().concat("?description=")+description;
        constructPageable(pr.findProductByDescription(description,page), propertiesService.getDefaultPageSize(), model,uri);
        return "products";
    }

    @RequestMapping("/products/brand")
    public String getProductByBrand(Model model, @RequestParam("brand") Integer brand, Pageable page, HttpServletRequest uriBuilder){
        //model.addAttribute("products",pr.getByBrand(brand, page));
        var uri = uriBuilder.getRequestURI().concat("?brand=")+brand;
        constructPageable(pr.findProductByBrand_Id(brand, page), propertiesService.getDefaultPageSize(), model,uri);
        return "products";
    }

    @RequestMapping("/products/price")
    public String getProductByPrice(Model model, @RequestParam("price") Float price, Pageable page, HttpServletRequest uriBuilder){
        var uri = uriBuilder.getRequestURI().concat("?price=")+price;
        constructPageable(pr.findProductByPrice(price, page), propertiesService.getDefaultPageSize(), model,uri);
        return "products";
    }

    @RequestMapping("/products/category")
    public String getProductByCategory(Model model, @RequestParam("category") String category, Pageable page, HttpServletRequest uriBuilder){
        var uri = uriBuilder.getRequestURI().concat("?category=")+category;
        constructPageable(pr.findProductByCategory_Name(category, page), propertiesService.getDefaultPageSize(), model,uri);
        return "products";
    }

    @RequestMapping("/products/{id}")
    public String getProduct(Model model, @PathVariable("id") Integer id){
        model.addAttribute("product",pr.findProductById(id));
        return "product";
    }

    @RequestMapping("/{name}")
    public String mainPage1(Model model, @PathVariable("name") String name){
        model.addAttribute("brands", br.getByName(name));
        model.addAttribute("categories",cr.getByName(name));
        model.addAttribute("products",pr.findAll());
        return "index";
    }

    @GetMapping("/login")
    public String loginPage(){
        return "login";
    }


    @GetMapping("/registration")
    public String registrationPage(Model model){
        if (!model.containsAttribute("form")) {
            model.addAttribute("form", new User());
        }

        return "registration";
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
            ur.save(user);
            return "redirect:/";
        }
    }

    @ExceptionHandler(ResourceNotFoundException.class)
    @ResponseStatus(HttpStatus.UNPROCESSABLE_ENTITY)
    private String handleRNF(ResourceNotFoundException ex, Model model) {
        model.addAttribute("resource", ex.getResource());
        model.addAttribute("id", ex.getId());
        return "resource-not-found";
    }
}
