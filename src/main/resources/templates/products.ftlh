<#import "/spring.ftl" as spring>
<#import "partials/main1.ftlh" as main />
<@main.renderWith  styles=["/css/products.css","https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.min.css","https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"] scripts=["/js/products.js"]>
   <div class="row">
        <div class="col">
            <form action="/products/name">
                <p><b><@spring.message "search.name" /></b></p>
                <div class="search-box">
                    <input class="search-txt" type="text" name="name" placeholder="<@spring.message "name" />">
                    <input type="hidden" name="page" value="0">
                    <input type="hidden" name="size" value="5">
                    <button type="submit" class="search-btn"><i class="fas fa-search"></i></button>
                </div>
            </form>
        </div>
        <div class="col">
            <form action="/products/description">
                <p><b><@spring.message "search.description" /></b></p>
                <div class="search-box">
                    <input class="search-txt" type="text" name="description" placeholder="<@spring.message "description" />">
                    <input type="hidden" name="page" value="0">
                    <input type="hidden" name="size" value="5">
                    <button type="submit" class="search-btn"><i class="fas fa-search"></i></button>
                </div>
            </form>
        </div>
        <div class="col">
            <a href="http://localhost:8000/products/basket"><i class="fas fa-shopping-cart" style="font-size: 5em; color: deepskyblue"></i></a>
        </div>

    </div>
    <div style="position: absolute; top: 0; left:0;">
        <form action="/products/brand">
            <p><b><@spring.message "filter.brands" /></b></p>
            <p><select size="5" name="brand">
                    <option disabled><@spring.message "choose.brand" /></option>
                    <option value="1">Samsung</option>
                    <option value="2">Nokia</option>
                    <option value="3">Xiaomi</option>
                    <option value="4">Huawei</option>
                </select></p>
            <input type="hidden" name="page" value="0">
            <input type="hidden" name="size" value="5">
            <p><input type="submit" value="<@spring.message "select" />"></p>
        </form>
        <form action="/products/category">
            <p><b><@spring.message "filter.categories" /></b></p>
            <p><select size="4" name="category">
                    <option disabled><@spring.message "choose.category" /></option>
                    <option value="Phone">Phone</option>
                    <option value="Laptop">Laptop</option>
                    <option value="TV">TV</option>
                </select></p>
            <input type="hidden" name="page" value="0">
            <input type="hidden" name="size" value="5">
            <p><input type="submit" value="<@spring.message "select" />"></p>
        </form>
        <form action="/products/price">
            <p><b><@spring.message "filter.price" /></b></p>
            <p><input name="price" type="radio" value="100">0 - 100</p>
            <p><input name="price" type="radio" value="500">0 - 500</p>
            <p><input name="price" type="radio" value="1000" checked>0 - 1000</p>
            <input type="hidden" name="page" value="0">
            <input type="hidden" name="size" value="5">
            <p><input type="submit" value="<@spring.message "select" />"></p>
        </form>
    </div>

    <div class="about-us my-5">
        <div class="container text-center">
            <h2 class="py-5 text-uppercase"><@spring.message "all.products" /></h2>
            <div class="row text-center">
                <#if products??>
                    <#list products as product>
                        <div class="card col-12 col-md-6 col-lg-4 mb-5" style="border-radius: 10%">
                            <div class="card1 h-100">
                                <img src="${product.img}" class="card-img-top" alt="Some Image0" style="height: 200px">
                                <div class="card-body border-top d-flex flex-column">
                                    <h5 class="card-title pb-5 text-uppercase">${product.name}</h5>
                                    <p><@spring.message "price" />: ${product.price}</p>
                                    <div class="text-center soc-net1">
                                        <a class="px-2" href="http://localhost:8000/products/${product.id}"><@spring.message "more" /></a>
                                    </div>
                                    <i onclick="addProduct(${product.id})" id="product${product.id}" class="fas fa-cart-plus" style="font-size: 3em"></i>
                                </div>
                            </div>
                        </div>

                    </#list>
                </#if>
                <#if notFound??>
                    <h3 class="py-5 text-uppercase">Products not found</h3>
                </#if>
            </div>
        </div>
    </div>

    <div>
        <#if hasPrev>
            <a id="loadPrev" href="${prevPageLink!''}">&lt;&lt;&lt;<@spring.message "prev.page" /></a>
        <#else>
            <span id="loadPrev"><@spring.message "f.page" /></span>
        </#if>

        <#if hasNext>
            <a id="loadNext" href="${nextPageLink!''}" data-default-page-size="${defaultPageSize!5}"><@spring.message "next.page" />&gt;&gt;&gt;</a>
        <#else>
            <span><@spring.message "l.page" /></span>
        </#if>
    </div>


</@main.renderWith>