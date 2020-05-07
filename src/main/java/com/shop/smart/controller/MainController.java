package com.shop.smart.controller;

import com.shop.smart.PropertiesService;
import com.shop.smart.model.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import com.shop.smart.repository.BrandRepository;
import com.shop.smart.repository.CategoryRepository;
import com.shop.smart.repository.ProductRepository;
import com.shop.smart.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
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
        return String.format("%s?page=%s&size=%s", uri, page, size);
    }


    @RequestMapping("/")
    public String mainPage(Model model){
        model.addAttribute("brands",br.findAll());
        model.addAttribute("categories",cr.findAll());
        model.addAttribute("products",pr.findAll());
        return "index";
    }

    @RequestMapping("/products")
    public String getProducts(Model model, Pageable page, HttpServletRequest uriBuilder){
        //model.addAttribute("products",pr.findAll(page));
        var uri = uriBuilder.getRequestURI();
        constructPageable(pr.findAll(page), propertiesService.getDefaultPageSize(), model,uri);
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

    @RequestMapping("/products/name")
    public String getProductByName(Model model, @RequestParam("name") String name){
        model.addAttribute("products",pr.getByName(name));
        return "products";
    }

    @RequestMapping("/products/description")
    public String getProductByDescription(Model model, @RequestParam("description") String description){
        model.addAttribute("products",pr.getByDescription(description));
        return "products";
    }

    @RequestMapping("/products/price")
    public String getProductByPrice(Model model, @RequestParam("price") Float price){
        model.addAttribute("products",pr.getByPrice(price));
        return "products";
    }

    @RequestMapping("/products/brand")
    public String getProductByBrand(Model model, @RequestParam("brand") Integer brand){
        model.addAttribute("products",pr.getByBrand(brand));
        return "products";
    }

    @RequestMapping("/products/category")
    public String getProductByCategory(Model model, @RequestParam("category") String category){
        model.addAttribute("products",pr.getByCategory(category));
        return "products";
    }
}
