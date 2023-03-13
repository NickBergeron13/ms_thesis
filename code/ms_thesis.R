library(DBI)
library(RSQLite)
ms_thesis_db <- dbConnect(RSQLite::SQLite(), "ms_thesis.db") 
dbExecute(ms_thesis_db, "CREATE TABLE aspen_plots (
          plot_id integer PRIMARY KEY,
          utm_x_start double,
          utm_y_start double,
          utm_x_end double,
          utm_y_end double) ;")
dbRemoveTable(ms_thesis_db,"aspen_plots")
aspen_plots <- read.csv("Aspen_Transect-GPS-Points_refined_final.csv", header = T)
dplyr::glimpse(aspen_plots)
dbWriteTable(ms_thesis_db, "aspen_plots", aspen_plots, append = TRUE)
dbGetQuery(ms_thesis_db, "SELECT * FROM aspen_plots LIMIT 10;")

dbExecute(ms_thesis_db, "CREATE TABLE trees (
          tree_id INTEGER PRIMARY KEY AUTOINCREMENT,
          tree_number integer NOT NULL,
          plot_id integer NOT NULL,
          year integer,
          FOREIGN KEY (plot_id) REFERENCES aspen_plots(plot_id)
          );")
trees <- read.csv("2022_aspen_data_suckers_tree.csv", header = TRUE)
trees$tree_id <- 1:nrow(trees)
dplyr::glimpse(trees)
library(dplyr)
trees <- select(trees, tree_id, tree_number, plot_id, year)
dbWriteTable(ms_thesis_db, "trees", trees, append = TRUE)
dbGetQuery(ms_thesis_db, "SELECT * FROM trees LIMIT 100;")

dbExecute(ms_thesis_db, "CREATE TABLE measurements (
          measurement_id INTEGER PRIMARY KEY AUTOINCREMENT,
          tree_id integer,
          height float CHECK (height<=1000),
          cag float CHECK (cag<=300),
          dbh float CHECK (dbh <=20),
          winter_browse integer CHECK (winter_browse <=1),
          summer_browse integer CHECK (summer_browse <=1),
          new_sucker integer CHECK (new_sucker <=1),
          FOREIGN KEY (tree_id) REFERENCES trees (tree_id)
          );")

measurements <- read.csv("2022_aspen_data_suckers_measurements_all.csv", header = TRUE)          
tree_id<- dbGetQuery(conn = ms_thesis_db, 
                     statement = "SELECT tree_id FROM trees;")
measurements <- cbind(measurements, tree_id)
measurements$measurement_id <- 1:nrow(measurements) 

measurements <- select(measurements, measurement_id, tree_id, height, cag, dbh,winter_browse, summer_browse, new_sucker)
dbWriteTable(ms_thesis_db, "measurements", measurements, append = TRUE)

dbGetQuery(ms_thesis_db, "SELECT * FROM measurements LIMIT 10")


