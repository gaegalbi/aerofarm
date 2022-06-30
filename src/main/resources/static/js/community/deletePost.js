function deletePost(postId) {
    let data = {
        id: Number(postId.substring(12, postId.length))
    };
    $.ajax({
        type: 'POST',
        url: '/deletePost',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(data),
    }).done(function () {
        alert('게시글이 삭제 처리 되었습니다.');
        window.location.href ='/community/detail/' + $('#post-id').val();
        // $('#comment-area').load(window.location.href + ' #comment-area');
    }).fail(function (error) {
        alert(JSON.stringify(error));
    });
}