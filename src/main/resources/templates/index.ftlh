<#import "/spring.ftl" as spring>
<#import "partials/main.ftlh" as main />
<@main.renderWith styles=["css/main.css","https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.min.css","https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"]>

    <h2><@spring.message "brands" /></h2>
    <ul>
        <div class="row text-center">
            <#list brands as brand>
                <div class="card col-12 col-md-6 col-lg-4 mb-5" style="border-radius: 10%">
                    <p>Name: ${brand.name}</p>
                    <img src="${brand.img}" alt="${brand.img}" style="width: 300px; height: 300px">
                </div>
            </#list>
        </div>
    </ul>
    <h2><@spring.message "categories" /></h2>
    <ul>
        <div class="row text-center">
            <#list categories as cat>
                <div class="card col-12 col-md-6 col-lg-4 mb-5" style="border-radius: 10%">
                    <p>Name: ${cat.name}</p>
                    <img src="${cat.img}" alt="${cat.img}" style="width: 300px; height: 300px">
                </div>
            </#list>
        </div>
    </ul>
</@main.renderWith>