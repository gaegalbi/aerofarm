let memberEdit = {
    init: function () {
        let _this = this;
        $('#edit-form').submit(function (event) {
            event.preventDefault();
            _this.profileEdit();
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
    }
};

memberEdit.init();