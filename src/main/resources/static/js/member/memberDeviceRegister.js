let memberDeviceRegister = {
    init: function () {
        let _this = this;
        $('#register-form').submit(function (event) {
            event.preventDefault();
            _this.registerDevice();
        });
    },
    registerDevice: function () {
        let data = {
            uuid: $('#uuid').val(),
            nickname: $('#nickname').val()
        };

        $.ajax({
            type: 'POST',
            url: '/my-page/devices/register',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(data),
        }).done(function (data, status, xhr) {
            alert(data['message']);
            location.href = '/my-page/devices';
        }).fail(function (xhr, status, error) {
            let parse = JSON.parse(xhr.responseText);
            $.each(parse.validation, function(key, value){
                $('#' + key).addClass('is-invalid')
                $('#' + key + "Error").text(value)
            });
        })
    }
};

memberDeviceRegister.init();