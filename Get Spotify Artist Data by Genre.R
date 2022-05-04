#' @TITLE: Get Spotify Artist Data by Genre
#' @DESCRIPTION: Uses the Spotify API to get data for artists in a particular genre
#' @PARAMETERS:
#'    - SPOTIFY_CLIENT_ID (char): string from the Spotify Developer platform to access the API
#'    - SPOTIFY_CLIENT_SECRET (char): string from the Spotify Developer platform to access the API
#'    - Genre (char): defines genre of artists that are to be pulled
#' @OUTPUT:
#'    - CSV file of artist data from the Spotify API (list elements are collapsed and separated with a "|")


##### LIBRARIES & FUNCTIONS #####
library(spotifyr)
library(httpuv)
library(dplyr)

##### PARAMETERS #####
# Sys.setenv(SPOTIFY_CLIENT_ID = '')
# Sys.setenv(SPOTIFY_CLIENT_SECRET = '')

genre<-"rap"



##### DATA PULL #####

access_token<-spotifyr::get_spotify_access_token() # Generates Spotify Access Token

genre_artists<-get_genre_artists(genre=genre, limit = 50) # Pull Top 50 Artist from Genre

artist_list<-genre_artists %>% # Create artist vector of names to pull artist details
  pull(name)


all_artists<-NULL # Create empty dataframe/variable to store the details together


for(artist in 1:length(artist_list)){
  features<-get_artist_audio_features(artist_list[artist]) # Grab all features for the ith artist
  all_artists<-rbind(all_artists, features) # Combine artist information together into single dataframe
  Sys.sleep(15) # 15 second pause to not overwhelm the API
}
rm(features)

all_artists_cleaned <- all_artists %>%
  rowwise() %>%
  mutate_if(is.list, ~paste(unlist(.), collapse = "|")) # Remove list column types in the dataframe by collapsing and separating with "|"



##### FILE OUTPUT #####
file.name<-paste(toupper(genre), "ARTIST DATA.csv") # Set File Name

write.csv(all_artists_cleaned, file = file.name, row.names = F) # Write the CSV File
