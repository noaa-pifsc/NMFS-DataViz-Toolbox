#2023 NMFS brand colors from 
#https://drive.google.com/drive/folders/1pcMRQHGdzX4NfsiDNTCYIBpRyP1-F57J

hex_nmfs <- c("#E7EFD5", "#CBDAC5", "#283A38", "#F1F2F3", "#CBCFD1", "#A5AAAF", 
              "#E9F3F6", "#D5E6ED", "#C2D9E3", "#F7FAEE", "#001743", "#323C46",
              "#4B8320", "#5761C0", "#DB6015", "#002364", "#B71300", "#00797F",
              "#003087", "#056FAA", "#00559B", "#3B469A", "#005E5E", "#737BE6",
              "#1EBEC7", "#A8B8FF", "#90DFE3", "#365E17", "#76BC21", "#B1DC6B",
              "#853B00", "#FF8400", "#FFAB38", "#901200", "#DB2207", "#FF6C57",
              "#0085CA", "#5EB6D9", "#C6E6F0", "#FFFFFF", "#A8821B", "#DDBB25",
              "#F0DE02", "#FFFF65")


oceans <- c("#001743", "#002364", "#003087", "#0085CA", "#5EB6D9", "#C6E6F0")
waves <- c("#005E5E", "#00797F", "#1EBEC7", "#90DFE3")
seagrass <- c("#365E17", "#4B8320", "#76BC21", "#B1DC6B")
urchin <- c("#3B469A", "#5761C0", "#737BE6", "#A8B8FF")
crustacean <- c("#853B00", "#DB6015", "#FF8400", "#FFAB38")
coral <- c("#901200", "#B71300", "#DB2207", "#FF6C57")
national <- "#002364"
westcoast <- "#00797F"
southeast <- "#4B8320"
midatlantic <- "#5761C0"
alaska <- "#DB6015"
pacificislands <- "#B71300"
regions <- c("#002364", "#00797F", "#4B8320", "#5761C0", "#DB6015", "#B71300")

#-------------------------------------------------------------------------------
#Assessing visibility using Viz Palette (https://projects.susielu.com/viz-palette)
#major conflict = colors difficult to tell apart as medium or large areas
#minor conflict = colors difficult to tell apart as lines or small points
#-------------------------------------------------------------------------------
#regions palette
"#002364", "#00797F", "#4B8320", "#5761C0", "#DB6015", "#B71300"

#Deuteranomaly - pass
#Protanomaly - pass
#Protanopia - minor conflict between #4B8320 and #B71300; major conflict between
#4B8320 and #DB6015
#Deuteranopia - minor conflict between #DB6015 and #4B8320; minor conflict between
#4B8320 and #B71300

#Major problem is #4B8320 - trying other colors in same green gradient:
#365E17 - Protanopia major conflict, Deuteranopia minor conflict, with #B71300
#76BC21 - no conflicts
#B1DC6B - no conflicts

#Suggested alternative region palettes that still use NMFS colors but have no
#visibility issues:

regions_alt1 <- c("#002364", "#00797F", "#76BC21", "#5761C0", "#DB6015", "#B71300")
regions_alt2 <- c("#002364", "#00797F", "#B1DC6B", "#5761C0", "#DB6015", "#B71300")

#-------------------------------------------------------------------------------
#oceans palette
"#001743", "#002364", "#003087", "#0085CA", "#5EB6D9", "#C6E6F0"

#Major conflict flagged for all visibility including no color deficiency - 
#002364 cannot be distinguished from either #001743 or #003087. Minor conflicts
# between #001743 and #003087 for Protanopia and Deuteranopia

#A simple swap that would help would be to remove #002364 and replace with 
#00559B. There are no major conflicts within any color population. Only minor
#conflicts between #00559B and #003087 for the four types of color deficiency

oceans_alt <- c("#001743", "#003087", "#00559B", "#0085CA", "#5EB6D9", "#C6E6F0")

#-------------------------------------------------------------------------------
#waves palette
"#005E5E", "#00797F", "#1EBEC7", "#90DFE3"

#Minor conflict flagged for all visibility including no color deficiency -
#005E5E vs. #00797F

#A simple swap that would help would be to replace #005E5E with #283A38. This
#is one of the NOAA background colors and is a gray with green undertones. The
#resulting palette has no color conflicts

waves_alt <- c("#283A38", "#00797F", "#1EBEC7", "#90DFE3")

#-------------------------------------------------------------------------------
#seagrass palette
"#365E17", "#4B8320", "#76BC21", "#B1DC6B"

#No color conflicts!

#-------------------------------------------------------------------------------
#urchin palette
"#3B469A", "#5761C0", "#737BE6", "#A8B8FF"

#Minor conflict flagged for all visibility including no color deficiency -
##5761C0 vs. both #3B469A and #737BE6

#A simple swap that would help would be to drop #5761C0 and add a lighter color
#to the end of the gradient. #F1F2F3 is a cool gray that is one of the NOAA 
#background colors and is a cool gray so I think it works visually with the 
#overall gradient. The resulting palette has no color conflicts

urchin_alt <- c("#3B469A", "#737BE6", "#A8B8FF", "#F1F2F3")

#-------------------------------------------------------------------------------
#crustacean palette
"#853B00", "#DB6015", "#FF8400", "#FFAB38"

#Minor conflict flagged for all visibility including no color deficiency -
#FF8400 vs. both #DB6015 and #FFAB38

#This one is trickier because it is a middle color...
#None of the three light gray options look great with this warm palette. 
#The dark red option #901200 is too similar to #853B00.
#Using a dark gray as the darkest option is ok but not great #283A38:

crustacean_alt1 <- c("#283A38", "#853B00", "#DB6015", "#FFAB38")

#We could use one from the NMFS yellow palette, although only #FFFF65 results in
#no conflicts with #FFAB38 and again it's ok but not great:

crustacean_alt2 <- c("#853B00", "#DB6015", "#FFAB38", "#FFFF65")

#If we go outside the strict NMFS brand colors and instead tweak #FF8400 by
#going one shade brighter to #FFDD6A, we get a gold with orange undertones
#that is more aligned with the overall gradient:

crustacean_alt3 <- c("#853B00", "#DB6015", "#FFAB38", "#FFDD6A")

#-------------------------------------------------------------------------------
#coral palette
"#901200", "#B71300", "#DB2207", "#FF6C57"

#Conflict flagged for all visibility including no color deficiency. Major 
#conflict for all color deficiencies, minor conflict for no color deficiency.
#B71300 vs. #901200

#Additional minor conflicts with #B71300 vs. #DB2207 for all visibility 
#including no color deficiency.

#Simplest to remove #B71300 but replacing it is a little tricky due to it being
#a middle color, this is similar to the problem with the crustacean palette.
#None of the three light gray options look great with this warm palette.
#Using a dark gray as the darkest option is ok but not great #283A38:

coral_alt1 <- c("#283A38","#901200", "#DB2207", "#FF6C57")

#If we go outside the strict NMFS brand colors and instead tweak #FF6C57 by
#going two shades brighter (I tried one but it wasn't enough) to #FFD1B4, we 
#get a tan with pink undertones that is more aligned with the overall gradient:

coral_alt2 <- c("#901200", "#DB2207", "#FF6C57", "#FFD1B4")
