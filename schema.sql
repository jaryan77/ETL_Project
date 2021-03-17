CREATE TABLE imdb(
 id INT PRIMARY KEY,
 imdb_id TEXT,
 movie_title TEXT,
 year TEXT,
 date_published TEXT,
 genre TEXT,
 runtime INT,
 country TEXT,
 language TEXT,
 director TEXT,
 writer TEXT,
 actors TEXT,
 imdb_avg_vote FLOAT,
 imdb_vote_count INT,
original_language TEXT,
 tagline TEXT,
 overview TEXT
);

CREATE TABLE rottentomatoes(
id INT primary key,
 movie_title TEXT,
 critics_consensus TEXT,
 content_rating TEXT,
 genres TEXT,
 director TEXT,
 production_company TEXT,
 rottentomatoes_critic_rating FLOAT,
 rottentomatoes_critic_count INT,
 rottentomatoes_audience_rating FLOAT,
 rottentomatoes_audience_count INT,
 runtime INT
);