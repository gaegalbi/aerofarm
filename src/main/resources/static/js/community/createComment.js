let createComment = {
    init : function () {
        let _this = this;

        $('#btn-createComment').on('click', function () {
            _this.createComment();
        });
    },
    createComment : function () {

        let token = $("meta[name='_csrf']").attr("content");
        let header = $("meta[name='_csrf_header']").attr("content");
        let data = {
            postId: $('#post-id').val(),
            content: $('#comment').val()
        };
        $.ajax({
            type: 'POST',
            url: '/community/createComment',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(data),
            beforeSend : function(xhr)
            {
                xhr.setRequestHeader(header, token); // CSRF
            },
        }).done(function () {
            alert('댓글 작성이 완료되었습니다.');
            $('#comment-area').load(window.location.href + ' #comment-area');
        }).fail(function (error) {
            alert(JSON.stringify(error));
        });
    }
};

createComment.init();