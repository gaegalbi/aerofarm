let eventsPost = {
    init : function () {
        let _this = this;

        $('#btn-eventsPost').on('click', function () {
            if ($('#post-id').val() == null) {
                _this.createBasicPost();
            } else {
                _this.createAnswerPost();
            }
        });
    },
    createBasicPost : function () {
        let token = $("meta[name='_csrf']").attr("content");
        let header = $("meta[name='_csrf_header']").attr("content");
        let data = {
            category: $('#category').val(),
            title: $('#title').val(),
            contents: $('#summernote').val()
        };
        $.ajax({
            type: 'POST',
            url: '/createBasicPost',
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
    },
    createAnswerPost : function () {
        let token = $("meta[name='_csrf']").attr("content");
        let header = $("meta[name='_csrf_header']").attr("content");
        let data = {
            category: $('#category').val(),
            title: $('#title').val(),
            contents: $('#summernote').val(),
            postId: $('#post-id').val()
        };
        $.ajax({
            type: 'POST',
            url: '/createAnswerPost/' + $('#post-id').val(),
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(data),
            beforeSend : function(xhr)
            {
                xhr.setRequestHeader(header, token); // CSRF
            },
        }).done(function () {
            alert('답글 작성이 완료되었습니다.');
            window.location.href ='/community/free?page=1';
        }).fail(function (error) {
            alert(JSON.stringify(error));
        });
    }
};

eventsPost.init();