<#import "/spring.ftl" as spring>
<#import "partials/main1.ftlh" as main />
<@main.renderWith styles=["css/login.css"]>
<section id="page-splash" class="page-splash">
    <div class="d-flex justify-content-center">
        <div class="mx-3">
            <form class="box-1" id="registration-form" action="/registration" method="post">
                <h1><@spring.message "signin" /></h1>
                <#if _csrf??>
                    <input type="hidden" name="${(_csrf.parameterName)!'csrf'}" value="${(_csrf.token)!'--no-token--'}"/>
                </#if>
                <input type="hidden" name="id" value="100">
                <input type="email" name="mail" placeholder="<@spring.message "user.mail" />">
                <input type="text" name="name" placeholder="<@spring.message "user.name" />">
                <input type="text" name="login" placeholder="<@spring.message "user.login" />">
                <input type="password" name="password" placeholder="<@spring.message "user.password" />">
                <button type="submit"><@spring.message "signin" /></button>
            </form>
        </div>
    </div>
    <div>
        <#if errors??>
            <p>Ошибки:</p>
            <#list errors as fieldError >
                <p>${fieldError.field} - ${fieldError.defaultMessage!"--no message--"}</p>
            </#list>
        </#if>
    </div>
</section>
</@main.renderWith>