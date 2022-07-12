let deviceDetail = {
    init: function () {
        let _this = this;
        $('#apply-btn').on('click', function () {
            _this.applySetting();
        });

        $('#retry-btn').on('click', function () {
            _this.getDeviceInfo();
        });
    },
    applySetting: function () {
        let data = {
            number: $('#number').val(),
            temperature: $('#tempRange').val(),
            humidity: $('#humiRange').val(),
            fertilizer: $('#fertRange').val(),
            ledOn: $('#ledSwitch').prop('checked'),
        };

        $.ajax({
            type: 'POST',
            url: '/my-page/devices/management',
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(data),
        }).done(function (data, status, xhr) {
            alert(data.message)
        }).fail(function (xhr, status, error) {
            alert(xhr.responseJSON['message']);
        })
    },
    getDeviceInfo: function () {
        return new Promise(function (resolve, reject) {
            $('#retry').hide()
            $('#spinner').show()
            $.ajax({
                type: 'POST',
                url: '/my-page/devices/request-info',
                data: {
                    number: $('#number').val()
                }
            }).done(function (data, status, xhr) {
                // alert(data.message)
                console.log(data)
                if (data['online']) {
                    $('#online').text("정상동작중")
                    $('#status').show()
                    $('#temp').text(data['temperature'])
                    $('#humi').text(data['humidity'])
                    $('#bright').text(data['brightness'])
                    $('#fert').text(data['fertilizer'])
                } else {
                    $('#online').text("오프라인");
                    $('#status').hide();
                }
                resolve();
            }).fail(function (xhr, status, error) {
                $('#online').text("오프라인");
                $('#status').hide();
            }).always(function () {
                $('#retry').show()
                $('#spinner').hide()
            })
        });
    },
    getDeviceSetting: function () {
        return new Promise(function (resolve, reject) {
            $.ajax({
                type: 'GET',
                url: '/api/devices/setting',
                dataType: 'json',
                contentType: 'application/json; charset=utf-8',
                data: {
                    number: $('#number').val()
                },
            }).done(function (data, status, xhr) {
                $('#uuid').val(data['uuid']);
                $('#tempRange').val(data['temperature']);
                $('#humiRange').val(data['humidity']);
                $('#fertRange').val(data['fertilizer']);
                if (data['ledOn']) {
                    $('#ledSwitch').attr('checked', true);
                }
                resolve();
            }).fail(function (xhr, status, error) {
                alert("해당 기기가 없습니다.")
                location.href = '/my-page/devices';
                reject();
            })
        });
    },
    firstInit: async function () {
        // let _this = this;
        await this.getDeviceSetting();
        await this.getDeviceInfo();
    },
};
// $('#spinner').hide();
$('#status').hide();
// await deviceDetail.getDeviceSetting()
// deviceDetail.getDeviceInfo();
deviceDetail.firstInit()
deviceDetail.init();