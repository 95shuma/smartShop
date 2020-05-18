<#import "partials/main.ftlh" as main />
<@main.renderWith styles=["css/main.css","https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.min.css","https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"] scripts=["/js/basket.js"]>
    <h1>Hello, ${user.name}</h1>

    <h2>Products in order</h2>
    <#if products??>
        <#list products as product>
            <li>
                <p>Name: ${product.product.name} X ${product.quantity}</p>
                <p>Price: ${product.product.price} X ${product.quantity} = ${product.product.price*product.quantity}</p>
            </li>
        </#list>
        <h3>Total: ${totalSum}</h3>
    </#if>
    <#if errors??>
        <h4>${errors}</h4>
    </#if>

</@main.renderWith>