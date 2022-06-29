let changePasswordPage = {
    init: function () {
        let _this = this;
        $('#reset-form').submit(function (event) {
            event.preventDefault();
            if ($('#password').val() === $('#confirmPassword').val()) {
                _this.changePassword();
            } else {
                $('#password').addClass('is-invalid');
                $('#password').val("")
                $('#confirmPassword').val("")
                // alert("비밀번호가 올바르지 않습니다.")
            }
        });
    },
    changePassword: function () {
        let data = {
            token: $('#token').val(),
            password: $('#password').val(),
            confirmPassword: $('#confirmPassword').val()
        };
        $.ajax({
            type: 'POST',
            url: '/login/reset-password/confirm-email',
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

changePasswordPage.init();