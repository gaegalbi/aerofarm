let eventsLike = {
    init : function () {
        let _this = this;

        $('#likeButton').on('click', function () {
            if ($('#likeButton').is(":checked") == true) {
                _this.createLike();
            } else {
                _this.deleteLike();
            }
        });
    },
    createLike : function () {

        /*let token = $("meta[name='_csrf']").attr("content");
        let header = $("meta[name='_csrf_header']").attr("content");*/
        let data = {
            postId: $('#post-id').val()
        };
        $.ajax({
            type: 'POST',
            url: '/createLike',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(data),
            /*beforeSend : function(xhr)
            {
                xhr.setRequestHeader(header, token); // CSRF
            },*/
        }).done(function () {
            alert('게시글을 추천합니다.');
            window.location.href ='/community/' + $('#post-category').val() + '/' + $('#post-id').val();
            // $('#createLike').load(window.location.href + ' #createLike');
        }).fail(function (error) {
            alert(JSON.stringify(error));
        });
    },
    deleteLike : function () {
/*
        let token = $("meta[name='_csrf']").attr("content");
        let header = $("meta[name='_csrf_header']").attr("content");*/
        let data = {
            postId: $('#post-id').val()
        };
        $.ajax({
            type: 'POST',
            url: '/deleteLike',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(data),
            /*beforeSend : function(xhr)
            {
                xhr.setRequestHeader(header, token); // CSRF
            },*/
        }).done(function () {
            alert('게시글 추천을 취소합니다.');
            window.location.href ='/community/' + $('#post-category').val() + '/' + $('#post-id').val();
            // $('#createLike').load(window.location.href + ' #createLike');
        }).fail(function (error) {
            alert(JSON.stringify(error));
        });
    }
};

eventsLike.init();