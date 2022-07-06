let deviceCreatePage = {
    init: function () {
        let _this = this;
        $('#create-form').submit(function (event) {
            event.preventDefault();
            _this.createDevice();
        });
    },
    createDevice: function () {
        let data = {
            model: $('#model').val(),
            quantity: $('#quantity').val()
        };

        $.ajax({
            type: 'POST',
            url: '/admin/devices/create',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(data),
        }).done(function (data, status, xhr) {
            $('#createdModal').modal('show');
            $('#model').val('');
            $('#quantity').val('');
        }).fail(function (xhr, status, error) {
            let parse = JSON.parse(xhr.responseText);
            $.each(parse.validation, function(key, value){
                $('#' + key).addClass('is-invalid')
                $('#' + key + "Error").text(value)
            });
        })
    }
};

deviceCreatePage.init();