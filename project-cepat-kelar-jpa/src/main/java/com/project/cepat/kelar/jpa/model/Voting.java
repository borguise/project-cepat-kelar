package com.project.cepat.kelar.jpa.model;

import com.project.cepat.kelar.common.model.ReferenceBase;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Entity(name = "VotingEntity")
@Table(name = "voting")
@Data
@EqualsAndHashCode(callSuper = false)
public class Voting extends ReferenceBase {

    private static final long serialVersionUID = -1846936771334681123L;

    @Column(name = "NAME")
    private String name;

    @Column(name = "START_DATE")
    private String startDate;

    @Column(name = "END_DATE")
    private String endDate;

    @Column(name = "TITLE")
    private String title;

    @Column(name = "DESCRIPTION", columnDefinition = "text")
    private String description;

    @Column(name = "STATUS")
    private String status;

    @Column(name = "POSTER_IMAGE")
    private String posterImage;

    @Column(name = "POSTER_IMAGE_DATA", columnDefinition = "bytea")
    private byte[] posterImageData;
}
