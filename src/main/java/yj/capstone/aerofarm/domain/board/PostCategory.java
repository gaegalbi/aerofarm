package yj.capstone.aerofarm.domain.board;

public enum PostCategory {
    ANNOUNCEMENT("공지사항"),
    INFORMATION("정보게시판"),
    TRADE("거래게시판"),
    QUESTION("질문게시판"),
    PICTURE("사진게시판"),
    FREE("자유게시판");

    private String category;

    PostCategory(String category) {
        this.category = category;
    }
}
