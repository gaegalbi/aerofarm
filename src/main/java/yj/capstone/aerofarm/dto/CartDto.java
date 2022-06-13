package yj.capstone.aerofarm.dto;

import lombok.*;

import java.util.Objects;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class CartDto {
    private Long productId;
    private int quantity;
}
