function AuthNuber() {

    //const phoneNumber = document.getElementById("phoneNumber").value
    const phoneNumber = $('#phoneNumber').val();

    $.ajax({
        url: "/my-page/edit/send-message",
        type: 'get',
        data: {
            "phoneNumber": phoneNumber
        },
        success: function (data) {
            $.ajax({
                url: "/my-page/edit/get-auth",
                type: 'get',
                data: {},
                success: function (data) {
                    const authNumber = data
                    const userNumber = prompt('인증번호를 입력하세요')
                    if (authNumber == userNumber)
                        alert('인증에 성공하였습니다.')
                    else
                        alert('인증에 실패하였습니다.')
                }
            })
        }
    })

    /*
    }).then((arg) => {

        $.ajax({
            url: "/my-page/edit/get-auth",
            type: 'get',
            data: {},
            success:function (data) {
                const authNumber = data
                const userNumber = prompt('인증번호를 입력하세요')
                if (authNumber == userNumber)
                    alert('인증에 성공하였습니다.')
                else
                    alert('인증에 실패하였습니다.')
            }
        })
    })
    */
}