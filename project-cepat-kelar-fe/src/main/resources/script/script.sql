ALTER TABLE comment ADD COLUMN article_id BIGINT;
ALTER TABLE comment ADD CONSTRAINT fk_comment_article 
    FOREIGN KEY (article_id) REFERENCES article(id);