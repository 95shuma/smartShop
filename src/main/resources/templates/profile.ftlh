<#import "/spring.ftl" as spring>
<#import "partials/main1.ftlh" as main />

<@main.renderWith styles=["css/profile.css","https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.min.css"]>
    <#if dto??>
        <div class="card">
            <h1><@spring.message "personal.data" /></h1>
            <p><i class="fas fa-user-circle" style="font-size: 7em; color: #3498db"></i></p>
            <h2>${dto.name}</h2>
            <p class="title">ID: ${dto.id}</p>
            <p><@spring.message "user-login" />: ${dto.login}</p>
            <p><@spring.message "Email" />: ${dto.mail}</p>
        </div>
    </#if>
    <#if error??>
        <h1>${error}</h1>
    </#if>
    <div class="bottom-box">
        <a href="/">На главную страницу</a>
    </div>
</@main.renderWith>