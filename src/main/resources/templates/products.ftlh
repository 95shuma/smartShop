<#import "partials/main.ftlh" as main />
<@main.renderWith  styles=["/css/products.css","https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.min.css","https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"] scripts=["/js/products.js"]>
    <#if authorization??>
        <input type="hidden" id="authorization" value="${authorization}">
    </#if>
    <div class="row">
        <div class="col">
            <form action="/products/name">
                <p><b>Поиск по названию</b></p>
                <p><input type="text" name="name" placeholder="name"></p>
                <input type="hidden" name="page" value="0">
                <input type="hidden" name="size" value="5">
                <p><input type="submit" value="Искать"></p>
            </form>
        </div>
        <div class="col">
            <form action="/products/description">
                <p><b>Поиск по описанию</b></p>
                <p><input type="text" name="description" placeholder="description"></p>
                <input type="hidden" name="page" value="0">
                <input type="hidden" name="size" value="5">
                <p><input type="submit" value="Искать"></p>
            </form>
        </div>
        <div class="col">
            <a href="http://localhost:8000/products/basket"><i class="fas fa-shopping-cart" style="font-size: 5em; color: deepskyblue"></i></a>
        </div>

    </div>
    <div style="position: absolute; top: 0; left:0;">
        <form action="/products/brand">
            <p><b>Отфильтровать по брэндам</b></p>
            <p><select size="5" name="brand">
                    <option disabled>Выберите брэнд</option>
                    <option value="1">Samsung</option>
                    <option value="2">Nokia</option>
                    <option value="3">Xiaomi</option>
                    <option value="4">Huawei</option>
                </select></p>
            <input type="hidden" name="page" value="0">
            <input type="hidden" name="size" value="5">
            <p><input type="submit" value="Выбрать"></p>
        </form>
        <form action="/products/category">
            <p><b>Отфильтровать по категориям</b></p>
            <p><select size="4" name="category">
                    <option disabled>Выберите брэнд</option>
                    <option value="Phone">Phone</option>
                    <option value="Laptop">Laptop</option>
                    <option value="TV">TV</option>
                </select></p>
            <input type="hidden" name="page" value="0">
            <input type="hidden" name="size" value="5">
            <p><input type="submit" value="Выбрать"></p>
        </form>
        <form action="/products/price">
            <p><b>Отфильтровать по ценам</b></p>
            <p><input name="price" type="radio" value="100">0 - 100</p>
            <p><input name="price" type="radio" value="500">0 - 500</p>
            <p><input name="price" type="radio" value="1000" checked>0 - 1000</p>
            <input type="hidden" name="page" value="0">
            <input type="hidden" name="size" value="5">
            <p><input type="submit" value="Выбрать"></p>
        </form>
    </div>
    

    <#include "partials/showproducts.ftlh">

</@main.renderWith>