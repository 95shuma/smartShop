'use strict'

function a_fun(){
    const candidateForm = document.getElementById("form-name");
    let data = new FormData(candidateForm);

    fetch("http://localhost:8000/products/name", {
        method: 'POST',
        body: data
    }).then(r => r.json());
};

