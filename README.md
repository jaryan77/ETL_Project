# ETL_Project Movie Analysis

## Goal
The goal of our ETL project was to join IMDB and Rotten Tomatoes data together into a more robust dataset to compare movies across different rating systems. 

# Extract
We found our datasets using www.Kaggle.com. These datasets were available for download as .csv's. We had the following datasets:

### CSVs
1) Rotten_Tomatoes_Movies
* https://www.kaggle.com/stefanoleone992/rotten-tomatoes-movies-and-critic-reviews-dataset?select=rotten_tomatoes_movies.csv
2) IMDB_Movies
* https://www.kaggle.com/stefanoleone992/imdb-extensive-dataset?select=IMDb+movies.csv
3) IMDB_Metadata
* https://www.kaggle.com/rounakbanik/the-movies-dataset?select=movies_metadata.csv

# Transform

## Pandas Analysis
1) We read our CSVs into pandas dataframes

2) We performed an initial data exploration of our datasets looking at our different columns & data types for each dataframe.

3) We discovered that the IMDB datasets were much more robust than the Rotten Tomatoes dataset. The decision was made to keep these datasets in seperate tables within the SQL database for end-users to consume.

* Rotten Tomatoes = 17,712 rows of data
* IMDB Movies = 85,855 rows of data
* IMDB Metadata = 45,466 rows of data

## Rotten Tomatoes Transformation
* We decided to alter the dataframe in the following ways (no "-->" kept as is):
    * 'rotten_tomatoes_link'--> DROPPED
    * 'movie_title'
    * 'movie_info'--> DROPPED obtained from IMDB
    * 'critics_consensus'
    * 'content_rating'
    * 'genres'
    * 'directors'--> RENAMED to 'director'
    * 'authors'--> DROPPED
    * 'actors'--> DROPPED obtained from IMDB
    * 'original_release_date'--> DROPPED obtained from IMDB
    * 'streaming_release_date'--> DROPPED
    * 'runtime'
    * 'production_company'
    * 'tomatometer_status'--> DROPPED
    * 'tomatometer_rating'--> RENAMED to 'rottentomatoes_critic_rating'
    * 'tomatometer_count'--> RENAMED to 'rottentomatoes_critic_count'
    * 'audience_status'--> DROPPED
    * 'audience_rating'--> RENAMED to 'rottentomatoes_audience_rating'
    * 'audience_count'--> RENAMED to  'rottentomatoes_audience_count'
    * 'tomatometer_top_critics_count' --> DROPPED
    * 'tomatometer_fresh_critics_count' --> DROPPED
    * 'tomatometer_rotten_critics_count' --> DROPPED
     
## IMDB Transformation
1) We decided to join the two IMDB tables using a left join with IMDB Metadata being joined onto the IMDB Movies dataset due to the IMDB Movies dataset having a more movies that we wanted to preserve. 

## Join Process
### IMDB Movies Columns
* We decided to alter the dataframe in the following ways (no "-->" kept as is):
  * 'imdb_title_id'--> Renamed to 'imdb_id'
  * 'title'--> DROPPED due to different languages
  * 'original_title'--> Kept due to English format --> RENAMED to 'movie_title'
  * 'year'
  * 'date_published'
  * 'genre'
  * 'duration'
  * 'country'
  * 'language'
  * 'director'
  * 'writer'
  * 'production_company'
  * 'actors'
  * 'description'
  * 'avg_vote'-->RENAMED to 'imdb_avg_vote'
  * 'votes'--> RENAMED to 'imdb_vote_count'
  * 'budget'-->DROPPED due to not enough time for currency conversion
  * 'usa_gross_income'-->DROPPED due to not enough time for currency conversion
  * 'worlwide_gross_income'-->DROPPED due to not enough time for currency conversion
  * 'metascore'-->DROPPED
  * 'reviews_from_users'-->DROPPED
  * 'reviews_from_critics'-->DROPPED

### IMDB Metadata Columns
* We decided to alter the dataframe in the following ways (no "-->" kept as is):
  * 'adult'-->DROPPED
  * 'belongs_to_collection'-->DROPPED
  * 'budget'-->DROPPED
  * 'genres'-->JOINED
  * 'homepage'-->DROPPED
  * 'id'-->DROPPED
  * 'imdb_id'
  * 'original_language'
  * 'original_title'-->JOINED
  * 'overview'
  * 'popularity'-->DROPPED
  * 'poster_path'-->DROPPED
  * 'production_companies'-->DROPPED
  * 'production_countries'-->DROPPED
  * 'release_date'-->DROPPED
  * 'revenue'-->DROPPED
  * 'runtime'-->JOINED
  * 'spoken_languages'-->DROPPED
  * 'status'-->DROPPED
  * 'tagline'
  * 'title'-->JOINED
  * 'video'-->DROPPED
  * 'vote_average'-->JOINED
  * 'vote_count'-->JOINED

# Load

## SCHEMA

### Rotten Tomatoes
* CREATE TABLE rottentomatoes (
  * id INT primary key,
  * movie_title TEXT,
  * critics_consensus TEXT,
  * content_rating TEXT,
  * genres TEXT,
  * director TEXT,
  * production_company TEXT,
  * rottentomatoes_critic_rating FLOAT,
  * rottentomatoes_critic_count INT,
  * rottentomatoes_audience_rating FLOAT,
  * rottentomatoes_audience_count INT,
  * runtime INT
);

### IMDB
* CREATE TABLE imdb (
  * id INT PRIMARY KEY,
  * imdb_id TEXT,
  * movie_title TEXT,
  * year TEXT,
  * date_published TEXT,
  * genre TEXT,
  * runtime INT,
  * country TEXT,
  * language TEXT,
  * director TEXT,
  * writer TEXT,
  * actors TEXT,
  * imdb_avg_vote FLOAT,
  * imdb_vote_count INT,
  * original_language TEXT,
  * tagline TEXT,
  * overview TEXT
);

# If we had more time...
 * We would normalize our data more intently
   * In our case it was difficult to discern what movies Rotten Tomatoes & IMDB share due to Movie Titles not matching and creating duplicates. This is why we had duplicate table columns between our tables to make sure analysis could be more robust and decrease chance of missing data.
 * Convert currency to USD and include financial data into our dataset