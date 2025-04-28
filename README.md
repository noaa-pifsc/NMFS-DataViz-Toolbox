# NMFS-DataViz-Toolbox
*In Development* Project repository for developing the code-based tools for crafting NMFS-branded publication- and presentation-ready data visualizations in [nmfsthemes](https://github.com/noaa-pifsc/nmfsthemes).

## Notes from the coding process
### Fonts
To use Arial font in the figures, I installed the extrafont package and worked
though the steps outlined in their [ReadMe](https://github.com/wch/extrafont).
To get the correct font name (ArialMT for Arial), I had to use `fonttable()` to
see the actual font names.  The names returned by `fonts()` are actually family
names, which isnʻt what R wants (despite the command being `family = `).