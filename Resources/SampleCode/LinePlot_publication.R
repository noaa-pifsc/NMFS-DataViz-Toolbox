# The purpose of this script is to create an example line plot that's 
# publication-ready and NMFS-branded. 

# Set up the environment
library(tidyverse, quietly = TRUE)
library(nmfspalette)
library(extrafont)

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

# Just a note that this code includes details that you'd only know if you 
# explored the data and tested out a few parameters.  
# Some of these things could be automated, like tying the axes limits to the 
# data limits.

# Create expression to include a subscript and subscripts in the y-axis label
yLabel <- expression(bold(Radiative ~ Forcing ~ of ~ CO[2] ~ (W ~ m^-2)))

# with base R
# dev.new(width = 6, height = 4, bg = "transparent") # or pdf() or png()
# pdf("LinePlot_pub.pdf", width = 6, height = 4, bg = "transparent", family = "ArialMT") # or png() or dev.new()
# png("LinePlot_pub.png", width = 6, height = 4, units = "in", res = 300, bg = "transparent", family = "ArialMT") # or pdf() or dev.new()
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
  geom_line(group = 1, color = "#0085CA", linewidth = 1.25) + 
  scale_x_continuous(name = "Year",
                     breaks = seq(1980, 2020, 5),  # where you want your major breaks and labels
                     minor_breaks = seq(1979, 2023, 1),  # where you want tick marks if more frequent than labels
                     guide = guide_axis(minor.ticks = T),  # adds the tick marks at minor breaks
                     expand = c(0,0)) + # remove padding
  scale_y_continuous(name = yLabel, 
                     breaks = seq(1, 2.2, 0.2), # where you want your major breaks and labels
                     minor_breaks = seq(1, 2.3, 0.1), # where you want tick marks if more frequent than labels
                     guide = guide_axis(minor.ticks = T),  # adds the tick marks at minor breaks
                     limits = c(1, 2.3),
                     expand = c(0,0)) + # remove padding
  theme(
    axis.title.x = element_text(face = "bold", size = 12),
    axis.title.y = element_text(size = 12),
    axis.text.x = element_text(size = 10),
    axis.text.y = element_text(size = 10),
    axis.line = element_line(), 
    panel.grid.minor = element_blank(),
    panel.grid.major = element_line(colour = '#F1F3F3'),
    panel.background = element_rect(fill = "transparent"),
    text = element_text(family = "ArialMT")
    )

# pdf("LinePlot_pub_ggplot.pdf", width = 6, height = 4, bg = "transparent") # or png() or ggsave()
# png("LinePlot_pub_ggplot.png", width = 6, height = 4, units = "in", res = 300, bg = "transparent") # or pdf() or ggsave()
p
# dev.off() # if using pdf() or png()

# This next step didn't prove necessary for me, but leaving it in here in case others need it
# embed_fonts("LinePlot_pub_ggplot.pdf", outfile="LinePlot_pub_ggplot_fontTest_embed.pdf")

