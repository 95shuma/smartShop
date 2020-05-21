<#import "/spring.ftl" as spring>
<#macro renderWith title="Welcome to Smart-Shop!" scripts=[] styles=["css/main.css","https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.min.css","https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"]>
    <!doctype html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport"
              content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <meta name="_csrf_header" content="${_csrf.headerName}" />
        <meta name="_csrf_token" content="${_csrf.token}" />

        <title>${title}</title>

        <link rel="stylesheet" href="css/main.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.min.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">

        <#list styles as styleSource>
            <link rel="stylesheet" href="${styleSource}">
        </#list>
    </head>
    <body>

        <div class="container">
            <div class="row header-1">
                <div class="col-2">
                    <div class="brain">
                        <a href="/" class="btn-1">
                            <i class="fas fa-brain"></i>
                        </a>
                    </div>
                </div>
                <div class="col-6">
                    <span style="font-size: 4em; color: #3498db">SMART </span><span style="font-size: 3em; color: #99FFFF">shop</span>
                </div>
                <div class="col-2">
                    <form id="lang-select" action="" method="get">
                        <label for="lang_select">
                            <@spring.message "label.language" />:
                        </label>
                        <select name="lang" id="lang_select">
                            <option value="ru-RU">Русский</option>
                            <option value="en-GB">British English</option>
                        </select>
                        <button onclick="changeLang()" type="button">
                            <@spring.message "button.language-change.text" />
                        </button>
                    </form>
                </div>
                <#if user??>
                    <input type="hidden" id="authorization" value="1">
                    <div class="col-1">
                        <h6><@spring.message "hello" />, <a class="flex box-128" href="/profile">${user.name}</a></h6>
                    </div>
                    <div class="col-1">
                        <form id="form-logout" class="flex box-128">
                            <#if _csrf??>
                                <input type="hidden" name="${(_csrf.parameterName)!'csrf'}" value="${(_csrf.token)!'--no-token--'}"/>
                            </#if>
                            <button type="button" onclick="logout()" class="flex box-128 logout-button btn btn-light"> <@spring.message "logout" /> </button>
                        </form>
                    </div>
                </#if>
                <#if nouser??>
                    <input type="hidden" id="authorization" value="0">
                    <div class="col-1">
                        <a class="flex box-128 btn btn-success" href="/registration"><h6> <@spring.message "signin" /> </h6></a>
                        <a class="flex box-128 btn btn-primary" href="/login"><h6> <@spring.message "login" /> </h6></a>
                    </div>
                    <div class="col-1">
                    </div>
                </#if>
            </div>
            <div class="row">
                <div class="col-12 col-md-6 col-lg-4">
                    <a href="/products?page=0&size=5"><h2><@spring.message "all.products" /></h2></a>
                </div>
                <div class="col-12 col-md-6 col-lg-4">
                    <a href="/"><h2><@spring.message "brands" /></h2></a>
                </div>
                <div class="col-12 col-md-6 col-lg-4">
                    <a href="/"><h2><@spring.message "categories" /></h2></a>
                </div>
            </div>
            <#--
             элемент nested указывает что в этом место
             будет подставлено некоторое содержимое,
             которое передаётся как тело макро-функции при её вызове
            -->
            <#nested>

        </div>

    <#list scripts as scriptSource>
        <script src="${scriptSource}"></script>
    </#list>
    <script>
        'use strict'

        function logout() {
            let form = document.getElementById("form-logout")
            let name1 = "_csrf"
            let value = document.getElementsByName("_csrf_token")[0].getAttribute("content")
            let data = new FormData();
            data.append(name1, value);
            console.log("1")
            fetch("http://localhost:8000/logout", {
                method: 'POST',
                body: data
            }).then(r => r.json()).then(data => {window.location.href = "http://localhost:8000/"})
        }

        function changeLang() {
            let form = document.getElementById("lang-select")
            let data = new FormData(form)
            let lang = data.get("lang")
            let a = document.getElementById("authorization").getAttribute("value")
            if(parseInt(a)==1) {
                let name1 = "_csrf"
                let value = document.getElementsByName("_csrf_token")[0].getAttribute("content")
                data.append(name1, value);
                fetch("http://localhost:8000/user/lang", {
                    method: 'POST',
                    body: data
                }).then(r => r.json());
            }
            window.location.replace("http://localhost:8000/?lang="+lang);
        }
    </script>
    </body>
</html>
</#macro>