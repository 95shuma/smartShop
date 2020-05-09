<#import "partials/main.ftlh" as main />
<@main.renderWith>
    <h1>Содержимое страницы</h1>
    <div class="flex flex-justify-content-center">
        <a class="flex box-128" href="/registration"> Регистрация </a>
        <a class="flex box-128" href="/login"> Войти </a>
        <a class="flex box-128" href="/profile"> Профиль </a>

        <form class="flex box-128" action="/logout" method="post">
            <#if _csrf??>
                <input type="hidden" name="${(_csrf.parameterName)!'csrf'}" value="${(_csrf.token)!'--no-token--'}"/>
            </#if>
            <button class="flex box-128 logout-button">Выйти </button>
        </form>

    </div>
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