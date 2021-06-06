# https://www.mit.edu/~amidi/teaching/data-science-tools/study-guide/data-visualization-with-r/
# https://jhrcook.github.io/ggasym/index.html
# https://github.com/rstudio/cheatsheets/blob/master/data-visualization-2.1.pdf
# https://datacarpentry.org/R-ecology-lesson/04-visualization-ggplot2.html#Plotting_with_ggplot2
# https://stackoverflow.com/questions/37750100/aggregating-data-with-ggplot


# Install ggplot2 as part of the whole tidyverse
install.packages("tidyverse")
install.packages("data.table")

library(ggplot2)
library(dplyr)
library(stringr)
library(data.table)

data <- rec.netRet784
data <- rec.netRet784.column4
data.c2 <- rec.netRet784.column2
data.c3 <- rec.netRet784.column3
data.c4 <- rec.netRet784.column4

xy <- data$V1
z <- data$V2

xy = str_extract_all(xy, "[0-9]+")

df = transpose(as.data.frame(do.call(cbind, xy)))

x=as.numeric(df$V1)
y=as.numeric(df$V2)
#z=as.numeric(rec.netRet784$V2)

dtv = data.frame(cbind(x,y,z))

# For column 2-4
x = str_replace_all(x, "[2]+", "1")
csx <- cumsum(x)


ggplot(data = dtv, aes(x = z, y = csx)) + geom_line() + labs(x = 'Time [ms]', y = 'Cumulative Spikes')  
ggplot(data = dtv, aes(x = z, y = csy)) + geom_line() + labs(x = 'Time [ms]', y = 'Cumulative Spikes')

ggplot(data = dtv, aes(x = z, y = x)) + geom_line() + labs(x = 'Time [ms]', y = 'Number of Spikes')
ggplot(data = dtv, aes(x = z, y = y)) + geom_line() + labs(x = 'Time [ms]', y = 'Number of Spikes')


ggplot() +
  geom_line(data = dtv, aes(x = z, y = x), color = "black") +
  geom_line(data = dtv, aes(x = z, y = y), color = "blue") +
  xlab('Time [s]') +
  ylab('Number of Spikes') +
  xlim(0, 1) +
  scale_x_continuous() +
  theme_bw()

ggplot(data = dtv, aes(x = z, y = csx)) + geom_line() +
  labs(x = 'Time [s]', y = 'Cumulative Spikes') +
  xlim(0, 1) +
  scale_x_continuous() +
  theme_bw()


ggplot(data = dtv, aes(x = z, y = csx)) + geom_density2d() + labs(x = 'Time [s]', y = 'Cumulative Spikes') + scale_y_continuous(limits=c(0, 125000)) + theme_bw()

geom_line(data = jobsAFAM1, aes(x = data_date, y = Percent.Change), color = "red")

ggplot(data = dtv, aes(x = z, y = csx)) + geom_point()
ggplot(data = dtv, aes(x = z, y = csx)) + geom_line()

ggplot(data = dtv, aes(x = z, y = x)) + geom_line()
ggplot(data = dtv, aes(x = z, y = y)) + geom_area()
ggplot(data = dtv, aes(x = z, y = y)) + geom_line()

#ggplot(data = dtv2, aes(x = z, y = csx)) + geom_line() + facet_wrap(facets = vars(x))

#ggplot(data = <DATA>, mapping = aes(<MAPPINGS>)) +  <GEOM_FUNCTION>()
ggplot(data = data, aes(x = substring(x, 13, 18), y = V2)) + geom_tile()

str_extract_all(x, "[0-9]+")[3]
#str_extract(substring(x, 13, 18),"(\n+)")

summary(data)


# install.packages("ggasym")