let orderDetail = {
    init: function () {
        let _this = this;
        $('#review-commit-btn').on('click', function () {
            _this.commitReview();
        });
    },
    commitReview: function () {
        // let token = $("meta[name='_csrf']").attr("content");
        // let header = $("meta[name='_csrf_header']").attr("content");
        let data = $('#reviewForm').serializeObject();
        $.ajax({
            type: 'POST',
            url: '/product/review',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(data),
            // beforeSend: function (xhr) {
            //     xhr.setRequestHeader(header, token); // CSRF
            // },
        }).done(function (data, status, xhr) {
            if (xhr.status === 200) {
                $('#reviewModal').modal('hide');
                $('#successModal').modal('show');
                $('#review-btn').attr('disabled', true);
            }
        }).fail(function (xhr, status, error) {
            alert('잘못된 접근입니다.')
        }).always(function () {

        })
    }
};

orderDetail.init();