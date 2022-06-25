const quantityCheck = (target) => {
    target.value = quantityValid(target.value);
}

function quantityValid(value) {
    if (value === '0') {
        return '1'
    }
    return value.replace(/[^0-9]/g, "");
}

let productDetail = {
    init: function () {
        let _this = this;
        $('#btn-addCart').on('click', function () {
            if ($('#quantity').val() > 0 && $('#quantity').val() < 100) {
                _this.addCart();
            } else {
                $('#quantity').addClass('is-invalid');
                alert('올바른 상품의 갯수를 입력해주세요!');
            }
        });
    },
    addCart: function () {
        // let token = $("meta[name='_csrf']").attr("content");
        // let header = $("meta[name='_csrf_header']").attr("content");
        let data = {
            productId: $('#productId').val(),
            quantity: $('#quantity').val()
        };
        $.ajax({
            type: 'POST',
            url: '/cart',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(data),
            // beforeSend: function (xhr) {
            //     xhr.setRequestHeader(header, token); // CSRF
            // },
        }).done(function (data, status, xhr) {
            if (xhr.status === 200) {
                $('#successModal').modal('show');
            }
            if (xhr.status === 202) {
                $('#existModal').modal('show');
            }
        }).fail(function (xhr, status, error) {
            window.location.href = '/login';
        });
    }
};

productDetail.init();