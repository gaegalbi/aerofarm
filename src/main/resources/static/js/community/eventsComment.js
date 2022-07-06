let eventsComment = {
    init : function () {
        let _this = this;

        $('#btn-createBasicComment').on('click', function () {
            _this.createBasicComment();
        });
        // $('#btn-createAnswerComment').on('click', function () {
        //     _this.createAnswerComment($('#btn-createAnswerComment').attr('value'), $('#btn-createAnswerComment').attr('name'));
        // });
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
    createAnswerComment : function (commentId, name) {
        var rname = '';
        if (name != undefined) {
            rname = name;
        }
        let data = {
            postId: $('#post-id').val(),
            content: $('#answer-textarea-' + rname + commentId).val(),
            commentId: commentId
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

function callAnswerCommentMethod(attValue, attName) {
    eventsComment.createAnswerComment(attValue, attName);
}