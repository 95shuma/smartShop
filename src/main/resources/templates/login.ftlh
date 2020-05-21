<#import "/spring.ftl" as spring>
<#import "partials/main1.ftlh" as main />

<@main.renderWith styles=["css/login.css"]>
    <form class="box-1" action="/login" method="post">
        <div>
            <#if error!false >
                <p style="color:red">Неверные имя пользователя или пароль !</p>
                <p><a href="/forgot-password"> Забыли </a>пароль</p>
            </#if>
        </div>
        <#if _csrf??>
            <input type="hidden" name="${(_csrf.parameterName)!'csrf'}" value="${(_csrf.token)!'--no-token--'}"/>
        </#if>
        <h1><@spring.message "login" /></h1>
        <input type="text" name="username" placeholder="<@spring.message "user.mail" />">
        <input type="password" name="password" placeholder="<@spring.message "user.password" />">
        <button type="submit"><@spring.message "login" /></button>
    </form>
</@main.renderWith>