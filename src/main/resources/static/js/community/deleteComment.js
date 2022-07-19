function deleteComment(commentId) {

    let data = {
        id: Number(commentId.substring(7, commentId.length))
    };

    if (confirm('정말 댓글을 삭제하시겠습니까?')) {
        $.ajax({
            type: 'POST',
            url: '/deleteComment',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(data),
        }).done(function () {
            alert('댓글이 삭제 처리 되었습니다.');
            window.location.href ='/community/detail/' + $('#post-id').val();
        }).fail(function (error) {
            alert(JSON.stringify(error));
        });
    }
}