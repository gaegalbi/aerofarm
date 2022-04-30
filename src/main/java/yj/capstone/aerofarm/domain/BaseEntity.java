package yj.capstone.aerofarm.domain;

import javax.persistence.MappedSuperclass;
import java.time.LocalDateTime;

@MappedSuperclass
public class BaseEntity {

    private LocalDateTime createdTime;
    private LocalDateTime lastModifiedTime;
}
