'use strict'

function addReview(id) {
    let form = document.getElementById("form-review-"+id);
    let data = new FormData(form);
    let name = "_csrf"
    let value = document.getElementsByName("_csrf_token")[0].getAttribute("content")
    data.append(name, value);
    data.append("id", id);

    fetch("http://localhost:8000/products/review/addReview", {
        method: 'POST',
        body: data
    }).then(r => r.json());
    form.reset();
    alert("Your review added");
}