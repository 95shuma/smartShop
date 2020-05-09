<#import "partials/main.ftlh" as main />

<@main.renderWith>
    <#if dto??>
        <h1>Ваши учетные данные!</h1>
        <p>${(dto.name)!'-- missing --'} - ${(dto.mail)!'-- email missing --'}</p>
    </#if>
    <#if error??>
        <h1>${error}</h1>
    </#if>
    <div class="bottom-box">
        <a href="/">На главную страницу</a>
    </div>
</@main.renderWith>