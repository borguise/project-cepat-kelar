package com.project.cepat.kelar.jpa.model;

import com.project.cepat.kelar.common.model.ReferenceBase;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Entity(name = "AudioEntity")
@Table(name = "audio")
@Data
@EqualsAndHashCode(callSuper = false)
public class Audio extends ReferenceBase {

    private static final long serialVersionUID = -5335082092622780452L;

    @Column(name = "CALL_NUMBER")
    private String callNumber;

    @Column(name = "SUBJECT")
    private String subject;

    @Column(name = "TITLE", columnDefinition = "text")
    private String title;

    @Column(name = "RESPONSIBILITY")
    private String responsibility;

    @Column(name = "GMD")
    private String gmd;

    @Column(name = "PUBLISHER")
    private String publisher;

    @Column(name = "ORIGIN_CITY")
    private String originCity;

    @Column(name = "PUBLISH_YEAR")
    private String publishYear;

    @Column(name = "MEDIA_TYPE")
    private String mediaType;

    @Column(name = "AUDIO_FORMAT")
    private String audioFormat;

    @Column(name = "STATUS")
    private String status;

    @Column(name = "COVER_IMAGE")
    private String coverImage;

    @Column(name = "COVER_IMAGE_DATA", columnDefinition = "bytea")
    private byte[] coverImageData;

    @Column(name = "AUDIO_FILE_NAME")
    private String audioFileName;

    @Column(name = "AUDIO_FILE_DATA", columnDefinition = "bytea")
    private byte[] audioFileData;
}
