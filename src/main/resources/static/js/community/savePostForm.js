let savePostForm = {
    init : function () {
        let _this = this;

        $('#btn-savePostForm').on('click', function () {
            _this.savePostForm();
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
            data: JSON.stringify(data),
        }).done(function () {
            $('#post-id').val() != '' ? alert('답글 작성이 완료되었습니다.') : $('#myId').val() != '' ? alert('수정이 완료되었습니다.') : alert('게시글 작성이 완료되었습니다.');
            window.location.href ='/community/free?page=1';
        }).fail(function (error) {
            alert(JSON.stringify(error));
        });
    }
};

savePostForm.init();