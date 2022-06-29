let eventsComment = {
    init : function () {
        let _this = this;

        $('#btn-createBasicComment').on('click', function () {
            _this.createBasicComment();
        });
        $('#btn-createAnswerComment').on('click', function () {
            _this.createAnswerComment();
        });
    },
    createBasicComment : function () {
        let data = {
            postId: $('#post-id').val(),
            content: $('#comment').val()
        };
        $.ajax({
            type: 'POST',
            url: '/createComment',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(data),
        }).done(function () {
            alert('댓글 작성이 완료되었습니다.');
            window.location.href ='/community/detail/' + $('#post-id').val();
        }).fail(function (error) {
            alert(JSON.stringify(error));
        });
    },
    createAnswerComment : function () {

        let data = {
            postId: $('#post-id').val(),
            content: $('#comment').val()
        };
        $.ajax({
            type: 'POST',
            url: '/createAnswerComment',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(data),
        }).done(function () {
            alert('댓글 작성이 완료되었습니다.');
            window.location.href ='/community/detail/' + $('#post-id').val();
        }).fail(function (error) {
            alert(JSON.stringify(error));
        });
    }
};

eventsComment.init();