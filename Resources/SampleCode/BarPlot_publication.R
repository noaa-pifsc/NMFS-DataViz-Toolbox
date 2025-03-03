# The purpose of this script is to create an example bar plot that's 
# publication-ready and NMFS-branded. 

# Set up the environment
library(tidyverse, quietly = TRUE)
library(nmfspalette)

### Access the data
# These data are not well formatted for easy ingestion (why is NOAA so bad at this?!)
# You can read about the data at: https://gml.noaa.gov/aggi/aggi.html
# We're going to skip the row that tells us that we're looking at 
# Global Radiative Forcing in W m-2
RadForcing <- read_csv("https://gml.noaa.gov/aggi/AGGI_Table.csv",
                       skip = 2,
                       show_col_types = FALSE)
# Also, the final few lines contain notes (sigh....)
RadForcing <- slice(RadForcing, -(46:49))

# Oddly, Year is treated as a character instead of a number
RadForcing$Year <- as.numeric(RadForcing$Year)

# Select only the fields for gases and year
# Rename chemical formulas with words, eliminate special characters
RadForcing_gases <- select(RadForcing, 
                           Year, 
                           `Carbon Dioxide` = CO2, 
                           Methane = CH4, 
                           `Nitrous Oxide` = N2O, 
                           CFCs = `CFC*`, 
                           HCFCs, 
                           HFCs = `HFCs*`) 

# Make the data "tidy" for easier plotting
RadForcing_tidy <- RadForcing_gases |>
  pivot_longer(cols = c(`Carbon Dioxide`, Methane, `Nitrous Oxide`, CFCs, HCFCs, HFCs),
               names_to = "GHG", values_to = "Forcing")

# Select the most recent year and order the values by their radiative forcing
RadForcing_latest <- filter(RadForcing_tidy, Year == max(Year)) |>
  arrange(desc(Forcing))

# Create a simple bar plot with the following attributes:
# NMFS-branded color - 2023 update
# Labeled or otherwise discernible axes maxima
# Minimal background grid for interpretation
# Transparent background (PIFSC requirement)
# Bold axes labels
# Bars ordered from greatest to least

# Still to add:
# size 12 font (generally, 10+ should work)
# Arial font (to render ʻŌlelo Hawaiʻi; Calibri works, too)
# Getting all the bar labels to print in the base R version

# Just a note that this code includes details that you'd only know if you 
# explored the data and tested out a few parameters.  
# Some of these things could be automated, like tying the axes limits to the 
# data limits.

# Create expression to include a subscript and subscripts in the y-axis label
yLabel <- expression(bold(Radiative ~ Forcing ~ (W ~ m^-2)))

# with base R
# dev.new(width = 6, height = 4, bg = "transparent") # or pdf() or png()
# pdf("BarPlot_pub.pdf", width = 6, height = 4, bg = "transparent") # or png() or dev.new()
# png("BarPlot_pub.png", width = 6, height = 4, units = "in", res = 300, bg = "transparent") # or pdf() or dev.new()
barplot(RadForcing_latest$Forcing, 
        ylim = c(0, 2.5), yaxt = "n", # suppress y-axis labels for now
        col = "#0085CA", border = NA)
        
# put a grid behind the plot, with the zero line in black
grid(nx = NA, ny = NULL,
     lty = 1, col = "#F1F3F3", lwd = 1)
abline(h = 0, col = "black", lwd = 1)

# put the plot over the grid, sigh
barplot(RadForcing_latest$Forcing, 
        ylim = c(0, 2.5), las = 1,
        col = "#0085CA", border = NA, 
        names.arg = RadForcing_latest$GHG,
        font.lab = 2,
        add = TRUE)
title(ylab = yLabel, line = 2.5) # move y-axis label so superscripts aren't cut off
# dev.off() # if using pdf() or png()

# ggplot2
# get the order of the gases, for arranging the bars
gases <- RadForcing_latest$GHG
p <- ggplot(RadForcing_latest, aes(GHG, Forcing)) + 
  geom_hline(yintercept = seq(0.5, 2.5, 0.5), color="#F1F3F3") + # horizontal grid lines
  geom_hline(yintercept = 0, color="black") + # zero line
  geom_col(fill = "#0085CA") + 
  scale_x_discrete(limits = gases) + 
  scale_y_continuous(name = yLabel, 
                     breaks = seq(0, 2.5, 0.5), limits = c(0, 2.5),
                     expand = c(0,0)) + # remove padding
  theme(
    axis.title.x = element_blank(),
    axis.title.y = element_text(size = 12),
    axis.text.x = element_text(size = 10),
    axis.text.y = element_text(size = 10),
    panel.grid.minor = element_blank(),
    panel.grid.major = element_blank(),
    panel.background = element_rect(fill = "transparent")
  )

# pdf("BarPlot_pub_ggplot.pdf", width = 6, height = 4, bg = "transparent") # or png() or ggsave()
# png("BarPlot_pub_ggplot.png", width = 6, height = 4, units = "in", res = 300, bg = "transparent") # or pdf() or ggsave()
print(p)
# dev.off() # if using pdf() or png()


