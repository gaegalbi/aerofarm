function searchPost(searchType, filterValue) {
    const myUrl = new URL(window.location.href);
    const urlParam = myUrl.searchParams;

    let searchUrl = window.location.href.split('?')[0];
     searchUrl += "?page=1";
    if (searchType == 'filter') {
        if (urlParam.has('filter')) {
            searchUrl += "&filter=" + urlParam.get('filter');
        } else {
            searchUrl += "&filter=" + filterValue;
        }
        if (urlParam.has('searchCategory')) {
            searchUrl += "&searchCategory=" + urlParam.get('searchCategory');
        }
        if (urlParam.has('keyword')) {
            searchUrl += "&keyword=" + urlParam.get('keyword');
        }
    } else {
        if (urlParam.has('filter')) {
            searchUrl += "&filter=" + urlParam.get('filter');
        }
        if (urlParam.has('searchCategory')) {
            searchUrl += "&searchCategory=" + urlParam.get('searchCategory');
        } else {
            searchUrl += "&searchCategory=" + $('#search_category').val();
        }
        if (urlParam.has('keyword')) {
            searchUrl += "&keyword=" + urlParam.get('keyword');
        } else {
            searchUrl += "&keyword=" + $('#keyword').val();
        }
    }
    window.location.href = searchUrl;
}