<#import "partials/main.ftlh" as main />
<@main.renderWith>
<section id="page-splash" class="page-splash">
    <div class="d-flex justify-content-center">
        <div class="mx-3">
            <form id="registration-form" action="/registration" method="post">
                <h3>Регистрация</h3>
                <input type="hidden" name="id" value="100">
                <input type="email" name="mail" class="form-control mb-1" placeholder="Email">
                <input type="text" name="name" class="form-control mb-1" placeholder="Полное имя">
                <input type="text" name="login" class="form-control mb-1" placeholder="Логин">
                <input type="password" name="password" class="form-control mb-1" placeholder="Пароль">
                <button class="btn btn-outline-primary btn-block" type="submit">Зарегистрироваться</button>
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