<div class="about-us my-5">
    <div class="container text-center">
        <h2 class="py-5 text-uppercase">All Products</h2>
        <div class="row text-center">
            <#if products??>
                <#list products as product>
                    <div class="card col-12 col-md-6 col-lg-4 mb-5">
                        <div class="card1 h-100">
                            <img src="${product.img}" class="card-img-top" alt="Some Image0" style="height: 200px">
                            <div class="card-body border-top d-flex flex-column">
                                <h5 class="card-title pb-5 text-uppercase">${product.name}</h5>
                                <p>Price: ${product.price}</p>
                                <div class="text-center soc-net1">
                                    <a class="px-2" href="http://localhost:8000/products/${product.id}">More</a>
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
        <a id="loadPrev" href="${prevPageLink!''}">&lt;&lt;&lt;Previous page</a>
    <#else>
        <span id="loadPrev">Previous page</span>
    </#if>

    <#if hasNext>
        <a id="loadNext" href="${nextPageLink!''}" data-default-page-size="${defaultPageSize!5}">Next page&gt;&gt;&gt;</a>
    <#else>
        <span>Next page</span>
    </#if>
</div>
