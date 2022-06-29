package yj.capstone.aerofarm.domain.board;

import lombok.Getter;
import yj.capstone.aerofarm.exception.NoCategoryFoundException;

import java.util.Arrays;

@Getter
public enum PostFilter {
    NORMAL("normal", "일반"),
    HOBBY("hobby", "취미"),
    GAME("game", "게임"),
    DAILY("daily", "일상"),
    TRAVEL("travel", "여행");

    private final String lowerCase;
    private final String name;

    PostFilter(String lowerCase, String name) {
        this.lowerCase = lowerCase;
        this.name = name;
    }

    public static PostFilter findByLowerCase(String lowerCase) {
        return Arrays.stream(PostFilter.values())
                .filter(filter -> filter.lowerCase.equals(lowerCase))
                .findAny()
                .orElseThrow(() -> new NoCategoryFoundException("해당 필터가 없습니다."));
    }
}
