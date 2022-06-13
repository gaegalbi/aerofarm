let cartList = {
    init : function () {
        let _this = this;
        $('.product').on('click', function () {
            let id = $(this).attr('id');
            _this.removeItem(id);
        });
    },
    removeItem : function (id) {
        // let token = $("meta[name='_csrf']").attr("content");
        // let header = $("meta[name='_csrf_header']").attr("content");
        let data = {
            productId: id
        };
        $.ajax({
            type: 'DELETE',
            url: '/cart',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(data),
            // beforeSend : function(xhr)
            // {
            //     xhr.setRequestHeader(header, token); // CSRF
            // },
        }).done(function (data) {
            if (data) {
                $('#removeModal').modal('show');
                let tempPrice = $('#cart'+id).find('#cartPrice').text()
                $('#totalPrice').text($('#totalPrice').text() - tempPrice)
                $('#totalPriceWithDelivery').text($('#totalPriceWithDelivery').text() - tempPrice)
                $('#cart' + id).remove();
            } else {
                $('#failModal').modal('show');
            }
        }).fail(function (xhr, status, error) {
            window.location.href ='/login';
        }).always(function (){
            if ($('#totalPrice').text() === '0') {
                $('#totalPriceCard').remove();
            }
        })
    }
};

cartList.init();