'use strict'

function logout() {
    let form = document.getElementById("form-logout")
    let data = new FormData(form)
    console.log("1")
    fetch("http://localhost:8000/logout", {
        method: 'POST',
        body: data
    }).then(r => r.json()).then(window.location("/"));
}