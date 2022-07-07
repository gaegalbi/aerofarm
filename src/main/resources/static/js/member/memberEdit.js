let memberEdit = {
    init: function () {
        let _this = this;
        $('#edit-form').submit(function (event) {
            event.preventDefault();
            _this.profileEdit();
        });
        $('#sms-btn').on('click', function (){
            _this.sendSms();
        })
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
        const inputNumber = prompt("전화번호 입력:")

        let data = {
            phoneNumber: inputNumber
        };

        $.ajax({
            url: "/api/auth/sms",
            type: 'POST',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(data)
        }).done(function (data) {
            const authNumber = prompt("휴대전화로 전송된 인증번호를 입력해주세요.")
            if(data == authNumber) {
                $("phoneNumber").attr("readonly", true)
                alert("인증 성공")
            }
            else
                alert("인증 실패")
        }).fail(function () {
            alert('실행 실패');
        })
    }
};

memberEdit.init();