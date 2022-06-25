let resetPasswordPage = {
    init: function () {
        let _this = this;
        $('#reset-form').submit(function (event) {
            event.preventDefault();
            _this.requestResetPassword();
        });
    },
    requestResetPassword: function () {
        let data = {
            email: $('#email').val()
        };
        $.ajax({
            type: 'POST',
            url: '/login/reset-password',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(data),
        }).done(function (data, status, xhr) {
            alert(data.message)
            location.href = '/login';
        }).fail(function (xhr, status, error) {
            let parse = JSON.parse(xhr.responseText);
            alert(parse.message)
        })
    }
};

resetPasswordPage.init();