let tinyEditor = tinymce.init({
    selector: 'textarea#tiny',
    menubar: false,
    paste_as_text: true,
    branding: false,
    plugins: "autolink code link autoresize paste image preview",
    toolbar: "undo redo | fontsizeselect | bold italic strikethrough underline | alignleft aligncenter alignright alignjustify | outdent indent ",
});

let createProduct = {
    init : function () {
        $(document).ready(function(){
            let query = window.location.search;
            let param = new URLSearchParams(query);
            let create = param.get('create');
            if (create === 'true') {
                $('#staticBackdrop').modal('show');
            }
        });
    },
};

createProduct.init();
