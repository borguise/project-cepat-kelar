package com.project.cepat.kelar.jpa.model;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "voting_entry")
@Data
public class VotingEntry {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "voting_id")
    private Voting voting;

    @Column(name = "NAME")
    private String name;

    @Column(name = "SUMMARY")
    private String summary;

    @Column(name = "IMAGE_URL")
    private String imageUrl;

    @Column(name = "VOTE_COUNT")
    private Integer voteCount = 0;
}