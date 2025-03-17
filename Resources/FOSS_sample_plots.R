library(httr)
library(jsonlite)
library(ggplot2)
library(dplyr)
library(forcats)

#download mid-Atlantic states striped bass data using FOSS API

bass_get <- GET("https://apps-st.fisheries.noaa.gov/ods/foss/landings/?offset=0&limit=10000",
                query = list(q = '{"ts_afs_name":"BASS, STRIPED","region_name":"Middle Atlantic"}'))

http_status(bass_get)
bass_list <- jsonlite::fromJSON(rawToChar(bass_get$content))
bass_df <- bass_list$items
str(bass_df)
View(bass_df)

#-------------------------------------------------------------------------------
#Data prep

#make state names a factor for easier plotting
bass_df$state_name <- as.factor(bass_df$state_name)

#initial plot to see what the data look like generally

ggplot(bass_df, aes(x = year, y = pounds, fill = state_name)) +
  geom_point(size = 4, color = "black", shape = 21) +
  scale_fill_manual(values = regions)

#1950-1970 looks like it might work for comparing palettes, also reorder factors
#by geography (North -> South)

bass_df_pre1970 <- bass_df |> 
  filter(year <= 1970) |> 
  mutate(state_name = fct_relevel(state_name, c("NEW YORK", "NEW JERSEY", "DELAWARE", "MARYLAND", "VIRGINIA")))

#-------------------------------------------------------------------------------
#Region palette compare

ggplot(bass_df_pre1970, aes(x = year, y = pounds, fill = state_name)) +
  geom_line(color = "black") +
  geom_point(size = 4, color = "black", shape = 21) +
  scale_fill_manual(values = regions)

ggplot(bass_df_pre1970, aes(x = year, y = pounds, fill = state_name)) +
  geom_line(color = "black") +
  geom_point(size = 4, color = "black", shape = 21) +
  scale_fill_manual(values = regions_alt1)

ggplot(bass_df_pre1970, aes(x = year, y = pounds, fill = state_name)) +
  geom_line(color = "black") +
  geom_point(size = 4, color = "black", shape = 21) +
  scale_fill_manual(values = regions_alt2)

#-------------------------------------------------------------------------------
#5-color categorical palette

ggplot(bass_df_pre1970, aes(x = year, y = pounds, fill = state_name)) +
  geom_line(color = "black") +
  geom_point(size = 4, color = "black", shape = 21) +
  scale_fill_manual(values = nmfs_cat5)

#-------------------------------------------------------------------------------
#Remove NY for 4-color palettes

bass_df_pre1970_noNY <- bass_df |> 
  filter(state_name != "NEW YORK") 

#-------------------------------------------------------------------------------
#4-color categorical palettes
ggplot(bass_df_pre1970_noNY, aes(x = year, y = pounds, fill = state_name)) +
  geom_line(color = "black") +
  geom_point(size = 4, color = "black", shape = 21) +
  scale_fill_manual(values = nmfs_cat1)

ggplot(bass_df_pre1970_noNY, aes(x = year, y = pounds, fill = state_name)) +
  geom_line(color = "black") +
  geom_point(size = 4, color = "black", shape = 21) +
  scale_fill_manual(values = nmfs_cat2)

ggplot(bass_df_pre1970_noNY, aes(x = year, y = pounds, fill = state_name)) +
  geom_line(color = "black") +
  geom_point(size = 4, color = "black", shape = 21) +
  scale_fill_manual(values = nmfs_cat3)

ggplot(bass_df_pre1970_noNY, aes(x = year, y = pounds, fill = state_name)) +
  geom_line(color = "black") +
  geom_point(size = 4, color = "black", shape = 21) +
  scale_fill_manual(values = nmfs_cat4)

#-------------------------------------------------------------------------------
#4-color gradient palettes
bass_df$state_name <- as.factor(bass_df$state_name)
bass_df_pre1970_noNY <- bass_df |> 
  filter(year <= 1970, state_name != "NEW YORK") |> 
  mutate(state_name = fct_relevel(state_name, c("NEW JERSEY", "DELAWARE", "MARYLAND", "VIRGINIA")))

#waves
ggplot(bass_df_pre1970_noNY, aes(x = year, y = pounds, fill = state_name)) +
  geom_line(color = "black") +
  geom_point(size = 4, color = "black", shape = 21) +
  scale_fill_manual(values = waves)

ggplot(bass_df_pre1970_noNY, aes(x = year, y = pounds, fill = state_name)) +
  geom_line(color = "black") +
  geom_point(size = 4, color = "black", shape = 21) +
  scale_fill_manual(values = waves_alt)

#urchin
ggplot(bass_df_pre1970_noNY, aes(x = year, y = pounds, fill = state_name)) +
  geom_line(color = "black") +
  geom_point(size = 4, color = "black", shape = 21) +
  scale_fill_manual(values = urchin)

ggplot(bass_df_pre1970_noNY, aes(x = year, y = pounds, fill = state_name)) +
  geom_line(color = "black") +
  geom_point(size = 4, color = "black", shape = 21) +
  scale_fill_manual(values = urchin_alt)

#crustacean
ggplot(bass_df_pre1970_noNY, aes(x = year, y = pounds, fill = state_name)) +
  geom_line(color = "black") +
  geom_point(size = 4, color = "black", shape = 21) +
  scale_fill_manual(values = crustacean)

ggplot(bass_df_pre1970_noNY, aes(x = year, y = pounds, fill = state_name)) +
  geom_line(color = "black") +
  geom_point(size = 4, color = "black", shape = 21) +
  scale_fill_manual(values = crustacean_alt1)

ggplot(bass_df_pre1970_noNY, aes(x = year, y = pounds, fill = state_name)) +
  geom_line(color = "black") +
  geom_point(size = 4, color = "black", shape = 21) +
  scale_fill_manual(values = crustacean_alt2)

ggplot(bass_df_pre1970_noNY, aes(x = year, y = pounds, fill = state_name)) +
  geom_line(color = "black") +
  geom_point(size = 4, color = "black", shape = 21) +
  scale_fill_manual(values = crustacean_alt3)

#coral
ggplot(bass_df_pre1970_noNY, aes(x = year, y = pounds, fill = state_name)) +
  geom_line(color = "black") +
  geom_point(size = 4, color = "black", shape = 21) +
  scale_fill_manual(values = coral)

ggplot(bass_df_pre1970_noNY, aes(x = year, y = pounds, fill = state_name)) +
  geom_line(color = "black") +
  geom_point(size = 4, color = "black", shape = 21) +
  scale_fill_manual(values = coral_alt1)

ggplot(bass_df_pre1970_noNY, aes(x = year, y = pounds, fill = state_name)) +
  geom_line(color = "black") +
  geom_point(size = 4, color = "black", shape = 21) +
  scale_fill_manual(values = coral_alt2)


