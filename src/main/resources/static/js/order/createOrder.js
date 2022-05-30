let createOrder = {
    init : function () {
        let _this = this;

        $('#btn-createOrder').on('click', function () {
            _this.createOrder();
        });
    },
    createOrder : function () {
        let token = $("meta[name='_csrf']").attr("content");
        let header = $("meta[name='_csrf_header']").attr("content");
        let data = {
            addressInfo: {
                address1: "seoul",
                address2: "gangnam",
                zipcode: "12345"
            },
            paymentType: "CREDIT_CARD",
            receiver: "QQC",
            orderLineDtos: [
                {
                    productDto: {
                        id: 1,
                        name: "Apple",
                        price: 1000
                    },
                    quantity: 5,
                    price: 1000
                },
                {
                    productDto: {
                        id: 2,
                        name: "Pear",
                        price: 3000
                    },
                    quantity: 3,
                    price: 3000
                },
                {
                    productDto: {
                        id: 3,
                        name: "Banana",
                        price: 1000
                    },
                    quantity: 1,
                    price: 1000
                }
            ]
        };
        $.ajax({
            type: 'POST',
            url: '/order/createOrder',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(data),
            beforeSend : function(xhr)
            {
                xhr.setRequestHeader(header, token); // CSRF
            },
        }).done(function () {
            alert('주문이 완료되었습니다.');
            window.location.href ='/';
        }).fail(function (error) {
            alert(JSON.stringify(error));
        });
    }
};

createOrder.init();