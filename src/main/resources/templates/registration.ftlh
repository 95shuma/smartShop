<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.min.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
</head>
<body id="body" class="no-scroll">
<!-- Splash screen -->
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
</body>
</html>

<script src="/js/script.js"></script>
