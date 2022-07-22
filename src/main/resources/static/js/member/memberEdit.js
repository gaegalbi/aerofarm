let memberEdit = {
    init: function () {
        let _this = this;
        $('#edit-form').submit(function (event) {
            event.preventDefault();
            _this.profileEdit();
        });
        $('#sms-btn').on('click', function (){
            _this.sendSms();
        });
        $('#auth-btn').on('click', function (){
            _this.validateSms();
        });
    },
    profileEdit: function () {
        let data = {
            nickname: $('#nickname').val(),
            name: $('#name').val(),
            phoneNumber: $('#phoneNumber').val(),
            address1: $('#address1').val(),
            address2: $('#address2').val(),
            zipcode: $('#zipcode').val(),
            extraAddress: $('#extraAddress').val()
        };

        $.ajax({
            type: 'POST',
            url: '/my-page/edit',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(data),
            // beforeSend: function (xhr) {
            //     xhr.setRequestHeader(header, token); // CSRF
            // },
        }).done(function (data, status, xhr) {
            alert(data.message)
            location.href = '/my-page/info';
        }).fail(function (xhr, status, error) {
            let parse = JSON.parse(xhr.responseText);
            $.each(parse.validation, function(key, value){
                $('#' + key).addClass('is-invalid')
                $('#' + key + "Error").text(value)
            });
        })
    },
    sendSms: function () {

        let data = {
            phoneNumber: $('#phoneNumber').val()
        }

        $.ajax({
            url: "/api/auth/sms",
            type: 'POST',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(data)
        }).done(function (data) {
            alert('인증번호를 전송하였습니다')
        }).fail(function () {
            alert('실행 실패');
        })
    },
    validateSms: function () {

        let data = {
            authNumber: $('#authNumber').val()
        }

        $.ajax({
            url: "/api/auth/validate",
            type: 'POST',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(data)
        }).done(function (data, status, xhr) {

        }).fail(function (xhr, status, error) {
            alert('잘못된 접근입니다')
        })
    }
};

memberEdit.init();