package yj.capstone.aerofarm.domain.device;

import lombok.Getter;
import yj.capstone.aerofarm.exception.NotFoundEnumException;

@Getter
public enum Model {
    JK_001("JK-001"),
    JK_002("JK-002"),
    DS_001("DS-001");

    private final String name;

    Model(String name) {
        this.name = name;
    }

    public static Model findModel(String model) {
        try {
            return Model.valueOf(model);
        } catch (IllegalArgumentException e) {
            throw new NotFoundEnumException("model", "해당되는 모델이 없습니다.");
        }
    }

}
