<#import "/spring.ftl" as spring>
<#import "partials/main1.ftlh" as main />
<@main.renderWith>
    <h2>${product.name}</h2>
    <img src="${product.img}">
    <p>ID: ${product.id}</p>
    <p><@spring.message "name" />: ${product.name}</p>
    <p><@spring.message "description" />: ${product.description}</p>
    <p><@spring.message "price" />: ${product.price}</p>
    <p><@spring.message "brand" />: ${product.brand.name}</p>
    <p><@spring.message "category" />: ${product.category.name}</p>
    <br>
    <br>
    <#if reviews??>
        <h2><@spring.message "reviews" /></h2>
        <#list reviews as review>
            <p style="font-size: 2em"><i class="fas fa-user"></i>${review.user.name}</p>
            <p>${review.text}</p>
        </#list>
    </#if>
    <#if error??>
        <p>${error}</p>
    </#if>
</@main.renderWith>