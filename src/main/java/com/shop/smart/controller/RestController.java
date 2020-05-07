package com.shop.smart.controller;

import com.shop.smart.PropertiesService;
import com.shop.smart.model.Product;
import com.shop.smart.repository.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@org.springframework.web.bind.annotation.RestController
public class RestController {

    private final PropertiesService propertiesService;

    @Autowired
    ProductRepository pr;

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
}
