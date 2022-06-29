function searchPost() {
    window.location.href = $('#hidden_category').val() +
        "?page=1&searchCategory=" + $('#search_category').val() +
        "&keyword=" + $('#keyword').val();
}

function filtering() {
    window.location.href = $('#hidden_category').val() +
        "?page=1&filter=" + $('#hidden-filter').val();
}

function select_filter(filter) {
    $('#hidden-filter').val(filter);
    filtering();
}