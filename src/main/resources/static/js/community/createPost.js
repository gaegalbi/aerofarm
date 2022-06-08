let createPost = {
    init : function () {
        let _this = this;

        $('#btn-createPost').on('click', function () {
            _this.createPost();
        });
    },
    createPost : function () {

        let token = $("meta[name='_csrf']").attr("content");
        let header = $("meta[name='_csrf_header']").attr("content");
        let data = {
            category: $('#category').val(),
            title: $('#title').val(),
            contents: $('#summernote').val()
        };
        $.ajax({
            type: 'POST',
            url: '/community/createPost',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(data),
            beforeSend : function(xhr)
            {
                xhr.setRequestHeader(header, token); // CSRF
            },
        }).done(function () {
            alert('게시글 작성이 완료되었습니다.');
            window.location.href ='/community/free?page=1';
        }).fail(function (error) {
            alert(JSON.stringify(error));
        });
    }
};

createPost.init();