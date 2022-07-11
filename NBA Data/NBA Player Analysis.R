#' NBA Player Stats
#' Source: https://www.nbastuffer.com/2021-2022-nba-player-stats/
#' Question: Player Substitutions?

rm(mtcars)

library(data.table)

players<-fread("NBA Data\\NBA Stats 202122 All Player Statistics.csv",
               sep=",")
head(players)

players.pca<-princomp(players[,-c(1:3)])
