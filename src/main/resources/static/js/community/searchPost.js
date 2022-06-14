function searchPost() {
    window.location.href = $('#hidden_category').val() +
        "?page=1&searchCategory=" + $('#search_category').val() +
        "&keyword=" + $('#keyword').val();
}