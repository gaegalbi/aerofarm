let memberEdit = {
    init: function () {
        let _this = this;
        $('#imgSendBtn').on('click', function (){
            _this.imgEdit();
        });
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
    imgEdit: function () {
        const img = $('#imgInput');

        const formData = new FormData();
        formData.append("profileImg", img.files[0]);

        $.ajax({
            type: 'POST',
            url: '/my-page/save-img',
            data: 'formData',
            processData: false,
            contentType: false
        }).done(function (data) {
            alert('실행 성공')
        }).fail(function () {
            alert('실행 실패')
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
            alert('실행 실패')
        })
    }
};

memberEdit.init();