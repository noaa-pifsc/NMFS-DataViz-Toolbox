# The purpose of this script is to create an example line plot that's 
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

# Create a simple line plot with the following attributes:
# NMFS-branded color - 2023 update
# Labeled or otherwise discernible axes maxima
# Minimal background grid for interpretation
# Transparent background (PIFSC requirement)
# Bold axes labels

# Still to add:
# size 12 font (generally, 10+ should work)
# Arial font (to render ʻŌlelo Hawaiʻi; Calibri works, too)

# Just a note that this code includes details that you'd only know if you 
# explored the data and tested out a few parameters.  
# Some of these things could be automated, like tying the axes limits to the 
# data limits.

# Create expression to include a subscript and subscripts in the y-axis label
yLabel <- expression(bold(Radiative ~ Forcing ~ of ~ CO[2] ~ (W ~ m^-2)))

# with base R
# dev.new(width = 6, height = 4, bg = "transparent") # or pdf() or png()
# pdf("LinePlot_pub.pdf", width = 6, height = 4, bg = "transparent") # or png() or dev.new()
# png("LinePlot_pub.png", width = 6, height = 4, units = "in", res = 300, bg = "transparent") # or pdf() or dev.new()
plot(RadForcing$Year, RadForcing$CO2, type = "l", lwd = 2, 
     xlim = c(1979, 2023), ylim = c(1, 2.3),
     xaxt = "n", yaxt = "n", # no axes ticks, so we can customize them
     xaxs = "i", yaxs = "i", # remove the padding R adds
     bty = "n", # remove box
     col = "#0085CA",
     xlab = "Year", ylab = "",
     # put a grid behind the plot
     panel.first = c(abline(v = seq(1980, 2020, 5), col = "#F1F3F3"),
                     abline(h = seq(1, 2.2, 0.2), col = "#F1F3F3")),
     font.lab = 2)
axis(1, at = c(seq(1979, 2023, 1)), labels = FALSE, tck = -0.01) # minor ticks
axis(1, at = c(seq(1980, 2020, 5)), tck = -0.03) # major ticks
axis(2, at = c(seq(1, 2.3, 0.1)), labels = FALSE, tck = -0.01) # minor ticks
axis(2, at = c(seq(1, 2.2, 0.2)), tck = -0.03, las = 1) # major ticks
title(ylab = yLabel, line = 2.5) # move y-axis label so superscripts aren't cut off
# dev.off() # if using pdf() or png()

# ggplot2
p <- ggplot(RadForcing, aes(Year, CO2)) + 
  geom_vline(xintercept = seq(1980, 2020, 5), color="#F1F3F3") + # vertical grid lines
  geom_hline(yintercept = seq(1, 2.2, 0.2), color="#F1F3F3") + # horizontal grid lines
  geom_line(group = 1, color = "#0085CA", linewidth = 1.25) + 
  scale_x_continuous(name = "Year",
                     breaks = seq(1979, 2023, 1),
                     labels = ~ifelse(.x %in% c(seq(1980, 2020, 5)), .x, ""), 
                     expand = c(0,0)) + # remove padding
  scale_y_continuous(name = yLabel, 
                     breaks = seq(1, 2.3, 0.1), limits = c(1, 2.3),
                     labels = ~ifelse(.x %in% c(seq(1, 2.2, 0.2)), .x, ""),
                     expand = c(0,0)) + # remove padding
  theme(
    axis.title.x = element_text(face = "bold", size = 12),
    axis.title.y = element_text(size = 12),
    axis.text.x = element_text(size = 10),
    axis.text.y = element_text(size = 10),
    panel.grid.minor = element_blank(),
    panel.grid.major = element_blank(),
    panel.background = element_rect(fill = "transparent")
    )

# pdf("LinePlot_pub_ggplot.pdf", width = 6, height = 4, bg = "transparent") # or png() or ggsave()
# png("LinePlot_pub_ggplot.png", width = 6, height = 4, units = "in", res = 300, bg = "transparent") # or pdf() or ggsave()
print(p)
# dev.off() # if using pdf() or png()


