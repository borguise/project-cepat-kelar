package com.project.cepat.kelar.jpa.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;

import com.project.cepat.kelar.common.model.ReferenceBase;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Entity
@Table(name = "highlight")
@Data
@EqualsAndHashCode(callSuper = false)
public class Highlight extends ReferenceBase {

    private static final long serialVersionUID = -6616077318371284458L;

    @Column(name = "QUESTION", columnDefinition = "text")
    private String question;

    @Column(name = "ANSWER", columnDefinition = "text")
    private String answer;

    @Column(name = "DISPLAY_ORDER")
    private Integer displayOrder;

    @Column(name = "STATUS")
    private String status;
}
