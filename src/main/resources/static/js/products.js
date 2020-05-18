'use strict'

function addProduct(id){
    let a = document.getElementById("authorization").getAttribute("value")
    if(parseInt(a)==1) {
        let name1 = "_csrf"
        let name = document.getElementsByName("_csrf_header")[0].getAttribute("content")
        let value = document.getElementsByName("_csrf_token")[0].getAttribute("content")
        let data = new FormData();
        data.append("id", id);
        data.append(name1, value);

        let product = document.getElementById("product" + id)
        if (product.classList.contains("fa-cart-plus")) {
            product.classList.remove("fa-cart-plus")
            product.classList.add("fa-cart-arrow-down")
        } else {
            product.classList.remove("fa-cart-arrow-down")
            product.classList.add("fa-cart-plus")
        }

        fetch("http://localhost:8000/products/basket/addInBasket/", {
            method: 'POST',
            body: data
        }).then(r => r.json());
    } else {
        alert("Only authorization user can add product in basket")
    }
};

