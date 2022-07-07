function AuthNuber() {

    let data = {
        phoneNumber: $('#phoneNumber').val()
    };
    $.ajax({
        url: "/api/auth/sms",
        type: 'POST',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(data)
    }).done(function (data) {
        alert("실행 성공")
    }).fail(function () {
        alert('실행 실패');
    })
}