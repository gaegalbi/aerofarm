package yj.capstone.aerofarm.dto;

import com.querydsl.core.annotations.QueryProjection;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class StoreReviewDto {

    private String reviewer;
    private String review;
    private int score;
    private LocalDateTime createdDate;

    @QueryProjection
    public StoreReviewDto(String reviewer, String review, int score, LocalDateTime createdDate) {
        this.reviewer = reviewer;
        this.review = review;
        this.score = score;
        this.createdDate = createdDate;
    }
}
