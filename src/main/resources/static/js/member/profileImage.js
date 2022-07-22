let profileImage = {
    init: function () {
        let _this = this;
        $('#editPicture').submit(function (event) {
            event.preventDefault();
            _this.uploadImage();
        });
    },
    uploadImage: function () {
        let form = $('#editPicture')[0];
        let data = new FormData(form);

        $.ajax({
            type: "POST",
            enctype: 'multipart/form-data',
            url: "/my-page/edit/picture",
            data: data,
            processData: false,
            contentType: false,
            cache: false
            //timeout: 600000,
        }).done(function (data, status, xhr) {
            $('#editProfileModal').modal('hide');
            alert('변경 완료.');
        }).fail(function (xhr, status, error) {
            let parse = JSON.parse(xhr.responseText);
            alert(parse['message']);
        })
    }
};

profileImage.init();