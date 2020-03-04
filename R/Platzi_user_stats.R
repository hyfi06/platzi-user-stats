# Copyright 2020 Hector Olvera-Vital

# This file is part of platzi-user-stats.
# platzi-user-stats is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# platzi-user-stats is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with platzi-user-stats.  If not, see <https://www.gnu.org/licenses/>.


library(lubridate)
library(ggplot2)
file = '../Mocks/datasheet.csv'

readData <- function(file, ...) {
  platzi_data  <- read.csv(file, header = TRUE, ...)
  
  expected_headers <- c("date", "name", "category", "type")
  have_expected_headers <- TRUE
  
  for (i in expected_headers) {
    have_expected_headers <- have_expected_headers && i %in% names(platzi_data)
  }
  
  if (!have_expected_headers){
    stop("Datasheet does not have the expected headers. 
    Verify that it contain 'date', 'name', 'category' and 'type'")
  }
  
  data_temp <- data.frame(
    ymd=date_temp_ymd <- ymd(platzi_data$date),
    dmy=data_temp_dmy <- dmy(platzi_data$date),
    mdy=data_temp_mdy <- dmy(platzi_data$date)
  )
  select_date <- which.min(colSums(is.na(data_temp)))
  
  if(sum(is.na(data_temp[,select_date])) == length(data_temp[,select_date])){
    stop("Error in dates, use format ymd, dmy or mdy ")
  } else {
    platzi_data$date <- data_temp[,select_date]
  }
  
  platzi_data$month <- format(platzi_data$date,'%Y-%m')
  platzi_data$week <- format(platzi_data$date,'%Y-%W')
  
  return(platzi_data)
}

graph_by_month <- function(platzi_user, platzi_data){
  platzi_plot <- ggplot(platzi_data, aes(x=as.factor(month)))
  
  pp_histogram <- platzi_plot + 
    geom_histogram(stat = 'count', aes(color = category, fill = type))
  
  pph_labels <- pp_histogram + xlab('Months') + 
    ylab('Count of certificates') +
    labs(title = paste0(platzi_user,"'s progress in Platzi by month"),
         color = 'Category',
         fill = 'Type')
  
  ggsave(filename = paste0(platzi_user,"-stats-by-month.png"),
         plot = pph_labels,
         width = 7,
         height = 5)
  return(pph_labels)
}
