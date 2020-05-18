'use strict'


function minusProduct(id) {
    let name = "_csrf"
    let value = document.getElementsByName("_csrf_token")[0].getAttribute("content")
    let data = new FormData();
    data.append("id",id);
    data.append(name,value);

    let product = document.getElementById("product"+id).getAttribute("value")
    if (parseInt(product)>0){
        let result = parseInt(product) - 1;
        document.getElementById("product"+id).setAttribute("value", result)

        fetch("http://localhost:8000/products/basket/addInBasket/minus/", {
            method: 'POST',
            body: data
        }).then(r => r.json());
    }else{
        alert("Product was deleted in Basket");
    }
}

function plusProduct(id) {
    let name = "_csrf"
    let value = document.getElementsByName("_csrf_token")[0].getAttribute("content")
    let data = new FormData();
    data.append("id",id);
    data.append(name,value);

    let product = document.getElementById("product"+id).getAttribute("value")
    let result = parseInt(product) + 1;
    document.getElementById("product"+id).setAttribute("value",result)

    fetch("http://localhost:8000/products/basket/addInBasket/plus/", {
        method: 'POST',
        body: data
    }).then(r => r.json());


}