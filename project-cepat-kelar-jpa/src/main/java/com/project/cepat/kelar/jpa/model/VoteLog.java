package com.project.cepat.kelar.jpa.model;

import jakarta.persistence.*;
import lombok.Data;
import java.util.Date;

@Entity
@Table(name = "vote_log")
@Data
public class VoteLog {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "VOTING_ID")
    private Long votingId;

    @Column(name = "ENTRY_ID")
    private Long entryId;

    @Column(name = "IP_ADDRESS")
    private String ipAddress;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "CREATED_AT")
    private Date createdAt = new Date();
}