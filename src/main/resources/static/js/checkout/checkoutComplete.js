let checkoutComplete = {
    init: function () {
        $(document).ready(function () {
            let token = $("meta[name='_csrf']").attr("content");
            let header = $("meta[name='_csrf_header']").attr("content");
            $.ajax({
                beforeSend: function (xhr) {
                    xhr.setRequestHeader(header, token); // CSRF
                },
                type: 'POST',
                url: '/cart/clear',
                dataType: 'html',
            })
        });
    },
};

checkoutComplete.init();