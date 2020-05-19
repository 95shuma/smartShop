<#import "partials/main.ftlh" as main />
<@main.renderWith styles=["css/main.css","https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.min.css","https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"]>
    <div class="row header-1">
        <div class="col-2">
            <div class="brain">
                <a href="/" class="btn-1">
                    <i class="fas fa-brain"></i>
                </a>
            </div>
        </div>
        <div class="col-6">
            <span style="font-size: 4em; color: #3498db">SMART </span><span style="font-size: 3em; color: #99FFFF">shop</span>
        </div>
        <#if user??>
            <div class="col-2">
                <h4>Hello, <a class="flex box-128" href="/profile">${user.name}</a></h4>
            </div>
            <div class="col-1">
                <form class="flex box-128" action="/logout" method="post">
                    <#if _csrf??>
                        <input type="hidden" name="${(_csrf.parameterName)!'csrf'}" value="${(_csrf.token)!'--no-token--'}"/>
                    </#if>
                    <button class="flex box-128 logout-button btn btn-light"> Logout </button>
                </form>
            </div>
        </#if>
        <#if nouser??>
            <div class="col-2">
                <a class="flex box-128 btn btn-success" href="/registration"><h4> Sign in </h4></a>
            </div>
            <div class="col-2">
                <a class="flex box-128 btn btn-primary" href="/login"><h4> Login </h4></a>
            </div>
        </#if>
    </div>
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