let checkoutPage = {
    init: function () {
        let _this = this;
        $('#same-address').on('click', function () {
            if ($(this).is(':checked')) {
                _this.getAddress();
            }
        });

        $('#checkout-form').submit(function (event) {
            event.preventDefault();
            _this.checkOut();
        });
    },
    getAddress: function () {
        $.ajax({
            type: 'GET',
            url: '/api/member/getAddress',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
        }).done(function (data, status, xhr) {
            $('#address1').val(data['address1']);
            $('#address2').val(data['address2']);
            $('#extraAddress').val(data['extraAddress']);
            $('#zipcode').val(data['zipcode']);
            $('#receiver').val(data['receiver']);
            $('#phoneNumber').val(data['phoneNumber']);
        });
    },
    checkOut: function () {
        let data = {
            saveAddress: $('#save-info').is(':checked'),
            paymentType: $("input[name='paymentType']:checked").val(),
            receiver: $('#receiver').val(),
            address1: $('#address1').val(),
            address2: $('#address2').val(),
            extraAddress: $('#extraAddress').val(),
            zipcode: $('#zipcode').val(),
            phoneNumber: $('#phoneNumber').val(),
            deposit: $('#deposit').val()
        };
        $.ajax({
            type: 'POST',
            url: '/checkout',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(data),
        }).done(function (data, status, xhr) {
            $.ajax({
                type: 'POST',
                url: '/cart/clear',
            })
            location.href = '/checkout/' + data['message'];
        }).fail(function (xhr, status, error) {
            console.log(xhr);
            let parse = JSON.parse(xhr.responseText);
            if (Object.keys(parse.validation).length > 0) {
                $.each(parse.validation, function(key, value){
                    $('#' + key).addClass('is-invalid')
                    $('#' + key + "Error").text(value)
                });
            } else {
                alert(parse.message)
            }
        })
    },
};

checkoutPage.init();