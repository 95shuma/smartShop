<#import "partials/main.ftlh" as main />
<@main.renderWith>
    <h1>Содержимое страницы</h1>
    <a href="http://localhost:8000/products?page=0&size=5"><h2>All Products</h2></a>
    <h2>Brands</h2>
    <ul>
        <#list brands as product>
            <li>
                <p>ID: ${product.id}</p>
                <p>Name: ${product.name}</p>
            </li>
        </#list>
    </ul>
    <h2>Categories</h2>
    <ul>
        <#list categories as cat>
            <li>
                <p>ID: ${cat.id}</p>
                <p>Name: ${cat.name}</p>
                <p>Description: ${cat.description}</p>
            </li>
        </#list>
    </ul>
</@main.renderWith>