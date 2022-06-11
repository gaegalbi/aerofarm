let createLike = {
    init : function () {
        let _this = this;

        $('#createLike').on('click', function () {
            _this.createLike();
        });
    },
    createLike : function () {

        let token = $("meta[name='_csrf']").attr("content");
        let header = $("meta[name='_csrf_header']").attr("content");
        let data = {
            postId: $('#post-id').val()
        };
        $.ajax({
            type: 'POST',
            url: '/community/createLike',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(data),
            beforeSend : function(xhr)
            {
                xhr.setRequestHeader(header, token); // CSRF
            },
        }).done(function () {
            alert('게시글을 추천합니다.');
            $('#createLike').load(window.location.href + ' #createLike');
        }).fail(function (error) {
            alert(JSON.stringify(error));
        });
    }
};

createLike.init();