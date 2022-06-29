let cartList = {
    init: function () {
        let _this = this;
        $('.product').on('click', function () {
            let id = $(this).attr('id');
            _this.removeItem(id);
        });
    },
    removeItem: function (id) {
        let data = {
            productId: id
        };
        $.ajax({
            type: 'DELETE',
            url: '/cart',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(data),
        }).done(function (data, status, xhr) {
            if (xhr.status === 200) {
                $('#removeModal').modal('show');
                let tempPrice = $('#cart' + id).find('#cartPrice').text()
                $('#totalPrice').text($('#totalPrice').text() - tempPrice)
                $('#totalPriceWithDelivery').text($('#totalPriceWithDelivery').text() - tempPrice)
                $('#cart' + id).remove();
            }
            if (xhr.status === 404) {
                $('#failModal').modal('show');
            }
        }).fail(function (xhr, status, error) {
            window.location.href = '/login';
        }).always(function () {
            if ($('#totalPrice').text() === '0') {
                $('#totalPriceCard').remove();
            }
        })
    }
};

cartList.init();