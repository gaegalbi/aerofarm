let resetPasswordPage = {
    init: function () {
        let _this = this;
        $('#reset-form').submit(function (event) {
            event.preventDefault();
            _this.requestResetPassword();
        });
        $('#sms-btn').on('click', function (){
            _this.sendSms();
        });
        $('#auth-btn').on('click', function (){
            _this.validateSms();
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
    },
    sendSms: function () {

        let data = {
            email : $('#id').val(),
            phoneNumber: $('#phoneNumber').val()
        }

        let number = {
            phoneNumber: $('#phoneNumber').val()
        }

        $.ajax({
            url: "/api/auth/get-number",
            type: 'POST',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(data)
        }).done(function (data, status, xhr) {
            console.log(data)
        }).fail(function (xhr, status, error) {

        })
/*
        $.ajax({
            url: "/api/auth/sms",
            type: 'POST',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(number)
        }).done(function (data) {
            alert('인증번호를 전송하였습니다')
        }).fail(function () {
            alert('전송 실패');
        })
*/
        
    },
    validateSms: function () {

        const authNumber = $('#authNumber').val();

        let data = {
            phoneNumber: $('#phoneNumber').val()
        }

        $.ajax({
            url: "/api/auth/get-token",
            type: 'POST',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(data)
        }).done(function (data) {
            if(authNumber==data) {
                const inputNumber = document.getElementById("inputNumber");

                inputNumber.removeAttribute("readonly");
                inputNumber.value = $('#phoneNumber').val();
                inputNumber.readOnly = true;

                alert('인증 성공')
            }
            else
                alert('인증 실패')
        }).fail(function () {
            alert('잘못된 접근입니다')
        })
    }
};

resetPasswordPage.init();