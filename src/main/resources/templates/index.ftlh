<#import "partials/main.ftlh" as main />
<@main.renderWith styles=["css/main.css","https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.min.css","https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"]>
    <#if user??>
        <div class="row">
            <div class="col-10">
                <h1>Hello, <a class="flex box-128" href="/profile">${user.name}</a></h1>
            </div>
            <div class="col-2">
                <form class="flex box-128" action="/logout" method="post">
                    <#if _csrf??>
                        <input type="hidden" name="${(_csrf.parameterName)!'csrf'}" value="${(_csrf.token)!'--no-token--'}"/>
                    </#if>
                    <button class="flex box-128 logout-button"> Logout </button>
                </form>
            </div>
        </div>
    </#if>
    <#if nouser??>
        <div class="flex flex-justify-content-center">
            <a class="flex box-128" href="/registration" style="font-size: 3em"> Sign in </a>
            <a class="flex box-128" href="/login" style="font-size: 3em"> Login </a>
        </div>
    </#if>
    <a href="/products?page=0&size=5"><h2>All Products</h2></a>
    <h2>Brands</h2>
    <ul>
        <div class="row text-center">
            <#list brands as brand>
                <div class="card col-12 col-md-6 col-lg-4 mb-5">
                    <p>ID: ${brand.id}</p>
                    <p>Name: ${brand.name}</p>
                    <img src="${brand.img}" alt="${brand.img}" style="width: 300px; height: 300px">
                </div>
            </#list>
        </div>
    </ul>
    <h2>Categories</h2>
    <ul>
        <div class="row text-center">
            <#list categories as cat>
                <div class="card col-12 col-md-6 col-lg-4 mb-5">
                    <p>ID: ${cat.id}</p>
                    <p>Name: ${cat.name}</p>
                    <p>Description: ${cat.description}</p>
                    <img src="${cat.img}" alt="${cat.img}" style="width: 300px; height: 300px">
                </div>
            </#list>
        </div>
    </ul>
</@main.renderWith>