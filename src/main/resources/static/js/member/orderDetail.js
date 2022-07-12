let orderDetail = {
    init: function () {
        let _this = this;
        $('#review-commit-btn').on('click', function () {
            _this.commitReview();
        });
        $('#waybill-btn').on('click', function (){
            _this.waybillEnquire();
        });
    },
    commitReview: function () {
        let data = $('#reviewForm').serializeObject();
        $.ajax({
            type: 'POST',
            url: '/product/review',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(data),
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
    },
    waybillEnquire: function () {


        //import {waybillApi} from "./waybillConfig";
        //alert(waybillApi);

        const apiKey = 'p0XRqBRiUyjyBdNATUg2bg';

        const selectValue = document.getElementById("chooseCompany");
        const company = selectValue.options[selectValue.selectedIndex].value;
        const waybill = $('#waybillInput').val();
        const url = 'http://info.sweettracker.co.kr/tracking/5?t_key=' + apiKey +'&t_code=' + company + '&t_invoice=' + waybill;



        $('#waybillForm').attr("action", url);
        //window.open(url);
    }
};

orderDetail.init();