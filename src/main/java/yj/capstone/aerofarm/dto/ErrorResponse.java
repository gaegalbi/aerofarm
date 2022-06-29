package yj.capstone.aerofarm.dto;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

import java.util.HashMap;
import java.util.Map;

/**
 * {
 *     "message":"잘못된 요청입니다.",
 *     "validation": {
 *         "title":"값을 입력해주세요"
 *     }
 * }
 */
@Getter
@RequiredArgsConstructor
public class ErrorResponse {
    private final String message;
    private final Map<String, String> validation = new HashMap<>();

    public void addValidation(String fieldName, String errorMessage) {
        this.validation.put(fieldName, errorMessage);
    }
}
