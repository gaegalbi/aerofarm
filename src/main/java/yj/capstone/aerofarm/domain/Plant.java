package yj.capstone.aerofarm.domain;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Plant extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;

    private int recommendTemp;

    private int recommendHumi;

    private int recommendFert;

    private int recommendBright;

    // 식물이 자라기 까지 걸리는 시간
    private int growthDay;
}
