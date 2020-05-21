<#import "/spring.ftl" as spring>
<#import "partials/main1.ftlh" as main />
<@main.renderWith styles=["css/main.css","https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.min.css","https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"] scripts=["/js/basket.js","/js/review.js"]>
    <h1>Hello, ${user.name}</h1>

    <h2><@spring.message "product.order" /></h2>
    <#if products??>
        <#list products as product>
            <li>
                <img src="${product.product.img}" style="width: 200px;height: 200px">
                <p><@spring.message "name" />: ${product.product.name} X ${product.quantity}</p>
                <p><@spring.message "price" />: ${product.product.price} X ${product.quantity} = ${product.product.price*product.quantity}</p>
            </li>
            <form id="form-review-${product.product.id}">
                <input type="text" name="review" minlength="4" maxlength="200">
                <button type="button" onclick="addReview(${product.product.id})"><@spring.message "add.review" /></button>
            </form>
        </#list>
        <h3><@spring.message "total" />: ${totalSum}</h3>
    </#if>
    <#if errors??>
        <h4>${errors}</h4>
    </#if>

</@main.renderWith>