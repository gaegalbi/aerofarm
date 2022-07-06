let checkoutComplete = {
    init: function () {
        $(document).ready(function () {
            $.ajax({
                type: 'POST',
                url: '/cart/clear',
                dataType: 'html',
            })
        });
    },
};

checkoutComplete.init();