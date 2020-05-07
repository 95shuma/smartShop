<#import "partials/main.ftlh" as main />
<@main.renderWith>
    <h2>${product.name}</h2>
    <img src="${product.img}">
    <p>ID: ${product.id}</p>
    <p>Name: ${product.name}</p>
    <p>Description: ${product.description}</p>
    <p>Price: ${product.price}</p>
    <p>Brand: ${product.brand.name}</p>
    <p>Category: ${product.category.name}</p>
</@main.renderWith>