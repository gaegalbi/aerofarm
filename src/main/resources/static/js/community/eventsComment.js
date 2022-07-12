let eventsComment = {
    init : function () {
        let _this = this;

        $('#btn-createBasicComment').on('click', function () {
            _this.createBasicComment();
        });
    },
    createBasicComment : function () {
        let text = $('#comment').val().replaceAll('\n', '<br>');

        let data = {
            postId: $('#post-id').val(),
            content: text
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
        let text = $('#answer-textarea-' + rname + commentId).val().replaceAll('\n', '<br>');
        let data = {
            id: commentId,
            postId: $('#post-id').val(),
            content: text,
            commentId: commentId
        };
        $.ajax({
            type: 'POST',
            url: $('#answer-textarea-' + rname + commentId).attr('name') == 'normal' ? '/createAnswerComment' : '/updateComment',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(data),
        }).done(function () {
            $('#answer-textarea-' + rname + commentId).attr('name') == 'normal' ? alert('댓글 작성이 완료되었습니다.') : alert('댓글 수정이 완료되었습니다.');
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