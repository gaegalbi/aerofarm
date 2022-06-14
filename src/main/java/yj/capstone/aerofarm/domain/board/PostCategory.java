package yj.capstone.aerofarm.domain.board;

import lombok.Getter;
import yj.capstone.aerofarm.exception.NoCategoryFoundException;

import java.util.Arrays;

@Getter
public enum PostCategory {
    ANNOUNCEMENT("announcement","공지사항"),
    INFORMATION("information","정보게시판"),
    TRADE("trade","거래게시판"),
    QUESTION("question","질문게시판"),
    PICTURE("picture","사진게시판"),
    FREE("free","자유게시판");

    private final String lowerCase;
    private final String name;

    PostCategory(String lowerCase, String name) {
        this.lowerCase = lowerCase;
        this.name = name;
    }

    public static PostCategory findByLowerCase(String lowerCase) {
        return Arrays.stream(PostCategory.values())
                .filter(category -> category.lowerCase.equals(lowerCase))
                .findAny()
                .orElseThrow(() -> new NoCategoryFoundException("해당 카테고리가 없습니다."));
    }
}
