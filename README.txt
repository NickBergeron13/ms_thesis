Owner: Nick Bergeron nick.bergeron@usu.edu Date:02/01/2023
Goal: Clean up and prepare apsen data recorded from 113 plots in northern Yellowstone taken annually from 1999-2022. The data is not 
standardized (i.e. blank spaces, placeholders, max values, etc). For this project, I will be standardizing all the data with the goal
of doing some data exploration and visualization. This will include things such as looking for obvious data entry errors, or examining 
trends in aspen counts, height, and browsing over time. Hopefully, the outputs will be some cool graphs and figures.

Data Owner: Dr. Eric Larsen (Univ. Wisconson Steven's Point) is the PI for the long-term aspen study, partnered with YNP and Dr. Dan MacNulty
(USU).

.gitignore: I have chosen to ignore the files below:
*.jpeg  *.docx (I don't want images and git can't track binary files like .docx)
output/  docs/ (These folders will have files we don't want to track so I will just ignore them completely)
*.Rhistory /.Rproj.user (These do not need to be tracked)
