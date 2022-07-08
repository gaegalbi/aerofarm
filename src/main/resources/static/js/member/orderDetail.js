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
        const myKey = "p0XRqBRiUyjyBdNATUg2bg";
        const selectValue = document.getElementById("chooseCompany");
        const company = selectValue.options[selectValue.selectedIndex].value;
        const waybill = $('#waybillInput').val();

        $.ajax({
            type: 'GET',
            //url: 'https://info.sweettracker.co.kr/api/v1/trackingInfo?t_key='+myKey+'&t_code='+company+'&t_invoice='+waybill
            url: 'https://info.sweettracker.co.kr/api/v1/trackingInfo?t_key=p0XRqBRiUyjyBdNATUg2bg&t_code=04&t_invoice=564639614980'
        }).done(function (data) {
            console.log(data);
            var myInvoiceData = "";
            if(data.status == false){
                myInvoiceData += ('<p>'+data.msg+'<p>');
            }else{
                myInvoiceData += ('<tr>');
                myInvoiceData += ('<th>'+"보내는사람"+'</td>');
                myInvoiceData += ('<th>'+data.senderName+'</td>');
                myInvoiceData += ('</tr>');
                myInvoiceData += ('<tr>');
                myInvoiceData += ('<th>'+"제품정보"+'</td>');
                myInvoiceData += ('<th>'+data.itemName+'</td>');
                myInvoiceData += ('</tr>');
                myInvoiceData += ('<tr>');
                myInvoiceData += ('<th>'+"송장번호"+'</td>');
                myInvoiceData += ('<th>'+data.invoiceNo+'</td>');
                myInvoiceData += ('</tr>');
                myInvoiceData += ('<tr>');
                myInvoiceData += ('<th>'+"송장번호"+'</td>');
                myInvoiceData += ('<th>'+data.receiverAddr+'</td>');
                myInvoiceData += ('</tr>');
            }

            $("#myPtag").html(myInvoiceData)

            var trackingDetails = data.trackingDetails;

            var myTracking="";
            var header ="";
            header += ('<tr>');
            header += ('<th>'+"시간"+'</th>');
            header += ('<th>'+"장소"+'</th>');
            header += ('<th>'+"유형"+'</th>');
            header += ('<th>'+"전화번호"+'</th>');
            header += ('</tr>');

            $.each(trackingDetails,function(key,value) {
                myTracking += ('<tr>');
                myTracking += ('<td>'+value.timeString+'</td>');
                myTracking += ('<td>'+value.where+'</td>');
                myTracking += ('<td>'+value.kind+'</td>');
                myTracking += ('<td>'+value.telno+'</td>');
                myTracking += ('</tr>');
            });

            $("#myPtag2").html(header+myTracking);



        }).fail(function (data) {
            alert('실행 실패')
        })
        /*
        let data = {
            company : $('#chooseCompany').select.val(),
            waybill : $('#waybillInput').val()
        }
        $.ajax({
            type: 'GET',
            url: '/product/waybill',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(data),
        }).done(function (data) {
            alert('실행 성공')
        }).fail(function (data) {
            alert('실행 실패')
        })

         */
    }
};

orderDetail.init();