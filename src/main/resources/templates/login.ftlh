<#import "partials/main.ftlh" as main />

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
        <h1>Login</h1>
        <input type="text" name="username" placeholder="Email address">
        <input type="password" name="password" placeholder="Password">
        <button type="submit">Login</button>
    </form>
    <div class="bottom-box">
        <a href="/">На главную страницу</a>
    </div>
</@main.renderWith>