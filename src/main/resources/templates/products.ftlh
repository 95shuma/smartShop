<#import "partials/main.ftlh" as main />
<@main.renderWith styles=["/css/products.css"]>
    <div>
        <form action="/products/name">
            <p><b>Поиск по названию</b></p>
            <p><input type="text" name="name" placeholder="name"></p>
            <p><input type="submit" value="Искать"></p>
        </form>
        <form action="/products/description">
            <p><b>Поиск по описанию</b></p>
            <p><input type="text" name="description" placeholder="description"></p>
            <p><input type="submit" value="Искать"></p>
        </form>
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
            <p><input type="submit" value="Выбрать"></p>
        </form>
        <form action="/products/price">
            <p><b>Отфильтровать по ценам</b></p>
            <p><input name="price" type="radio" value="100">0 - 100</p>
            <p><input name="price" type="radio" value="500">0 - 500</p>
            <p><input name="price" type="radio" value="1000" checked>0 - 1000</p>
            <p><input type="submit" value="Выбрать"></p>
        </form>
    </div>
    <#include "partials/showproducts.ftlh">

</@main.renderWith>