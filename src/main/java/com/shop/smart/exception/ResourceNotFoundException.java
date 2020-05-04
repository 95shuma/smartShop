package com.shop.smart.exception;

import lombok.Getter;
import lombok.Setter;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(code = HttpStatus.NOT_FOUND)
@Getter @Setter
public class ResourceNotFoundException extends RuntimeException {
    private String resource;
    private int id;
    public ResourceNotFoundException(String resource, int id) {
        super();
        this.id = id;
        this.resource = resource;
    }
}
