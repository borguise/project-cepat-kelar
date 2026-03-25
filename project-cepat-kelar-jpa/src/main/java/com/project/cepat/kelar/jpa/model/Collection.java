package com.project.cepat.kelar.jpa.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;

import com.project.cepat.kelar.common.model.ReferenceBase;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Entity(name = "CollectionEntity")
@Table(name = "collection")
@Data
@EqualsAndHashCode(callSuper = false)
public class Collection extends ReferenceBase {

    private static final long serialVersionUID = -5335082092622780451L;

    @Column(name = "SUBJECT")
    private String subject;

    @Column(name = "TITLE", columnDefinition = "text")
    private String title;

    @Column(name = "AUTHOR")
    private String author;

    @Column(name = "PUBLISHER")
    private String publisher;

    @Column(name = "PUBLISH_CITY")
    private String publishCity;

    @Column(name = "PUBLISH_YEAR")
    private String publishYear;

    @Column(name = "PHYSICAL_DESCRIPTION", columnDefinition = "text")
    private String physicalDescription;

    @Column(name = "ISBN")
    private String isbn;

    @Column(name = "STOCK")
    private Integer stock;

    @Column(name = "CALL_NUMBER")
    private String callNumber;

    @Column(name = "STATUS")
    private String status;

    @Column(name = "COVER_IMAGE")
    private String coverImage;

    @Column(name = "COVER_IMAGE_DATA", columnDefinition = "bytea")
    private byte[] coverImageData;
}
