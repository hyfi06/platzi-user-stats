#! /usr/bin/Rscript

# Copyright 2020 Hector Olvera-Vital

# This file is part of platzi-user-stats.
# 
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

main <- function() {
  source("Platzi_user_stats.R")
  
  platzi_user <- readline(prompt="Enter your user in Platzi: ")
  file_name <- readline(prompt="Enter datasheet name(with .csv): ")
  
  platzi_data <- readData(file_name)
  
  plot_by_month <- graph_by_month(platzi_user, platzi_data)
}

if(interactive()) main()