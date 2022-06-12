let productDetail = {
    init : function () {
        let _this = this;
        $('#btn-addCart').on('click', function () {
            _this.addCart();
        });
    },
    addCart : function () {
        let token = $("meta[name='_csrf']").attr("content");
        let header = $("meta[name='_csrf_header']").attr("content");
        let data = {
            productId: $('#productId').val(),
            quantity: $('#quantity').val()
        };
        $.ajax({
            type: 'PUT',
            url: '/cart',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(data),
            beforeSend : function(xhr)
            {
                xhr.setRequestHeader(header, token); // CSRF
            },
        }).done(function (data) {
            if (data) {
                $('#successModal').modal('show');
            } else {
                $('#existModal').modal('show');
            }
        }).fail(function (xhr, status, error) {
            window.location.href ='/login';
        });
    }
};

productDetail.init();