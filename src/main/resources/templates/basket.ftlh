<#import "/spring.ftl" as spring>
<#import "partials/main1.ftlh" as main />
<@main.renderWith styles=["css/main.css","https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.min.css","https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"] scripts=["/js/basket.js"]>
    <h1><@spring.message "hello" />, ${user.name}</h1>

    <h2><@spring.message "product.basket" /></h2>
    <#if products??>
        <#list products as product>
            <li>
                <p>ID: ${product.product.id}</p>
                <p><@spring.message "name" />: ${product.product.name}</p>
                <p><@spring.message "description" />: ${product.product.description}</p>
                <p><i onclick="minusProduct(${product.product.id})" id="productminus${product.product.id}" class="fas fa-minus-square" style="color: red; font-size: 3em"></i>
                <input id="product${product.product.id}" type="text" value="${product.quantity}" style="font-size: 3em; width: 150px" disabled>
                <i onclick="plusProduct(${product.product.id})" id="productplus${product.product.id}" class="fas fa-plus-square" style="color: green; font-size: 3em"></i></p>
                <img src="${product.product.img}" alt="${product.product.img}" style="width: 300px; height: 300px">
            </li>
        </#list>
        <a class="btn btn-primary" href="http://localhost:8000/products/order" style="font-size: 3em"><@spring.message "buy" /></a>
    </#if>
    <#if error??>
        <h4>${error}</h4>
    </#if>

</@main.renderWith>