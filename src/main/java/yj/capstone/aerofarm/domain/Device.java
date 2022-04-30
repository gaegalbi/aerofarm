package yj.capstone.aerofarm.domain;

import javax.persistence.*;

@Entity
public class Device extends BaseEntity{

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String nickname;

    private int temperature;

    private int humidity;

    /**
     * 양액의 경우 ml 단위로 할건지?
     * float 고려
     */
    private int fertilizer;

    private int brightness;

    private String deviceImage;

    @Enumerated(EnumType.STRING)
    private Model model;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "plant_id")
    private Plant plant;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id")
    private Member owner;
}
