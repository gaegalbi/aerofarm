let savePostForm = {
    init : function () {
        let _this = this;

        $('#post-form').submit(function (event) {
            if ($('#summernote').summernote('isEmpty')) {
                event.preventDefault();
                alert("내용이 비어있습니다.");
            } else {
                event.preventDefault();
                _this.savePostForm();
            }
        });
    },
    savePostForm : function () {
        let data = {
            id: $('#myId').val(),
            category: $('#category').val(),
            filter: $('#filter').val(),
            title: $('#title').val(),
            contents: $('#summernote').val(),
            postId: $('#post-id').val()
        };

        $.ajax({
            type: 'POST',
            url: $('#post-id').val() != '' ? '/createAnswerPost' : $('#myId').val() != '' ? '/updatePost' : '/createBasicPost',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(data)
        }).done(function (data) {
            alert(data.message);
            window.location.href ='/community/all?page=1';
        }).fail(function (error) {
            alert(JSON.stringify(error));
        });
    }
};

savePostForm.init();