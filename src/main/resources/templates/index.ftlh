<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Smart-Shop</title>
</head>
<body>
<h1>Содержимое страницы</h1>
<h2>Brands</h2>
<ul>
    <#list brands as product>
        <li>
            <p>ID: ${product.id}</p>
            <p>Name: ${product.name}</p>
        </li>
    </#list>
</ul>
<h2>Categories</h2>
<ul>
    <#list categories as cat>
        <li>
            <p>ID: ${cat.id}</p>
            <p>Name: ${cat.name}</p>
            <p>Description: ${cat.description}</p>
        </li>
    </#list>
</ul>

</body>
</html>