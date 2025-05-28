# PROBLEM 1
input <- ("
Instructor Location Attendees
Ren North 7
Ren North 22
Ren North 6
Ren North 15
Ren South 12
Ren South 13
Ren South 14
Ren South 16
Stimpy North 18
Stimpy North 17
Stimpy North 15
Stimpy North 9
Stimpy South 15
Stimpy South 11
Stimpy South 19
Stimpy South 23
")

data <- read.table(textConnection(input), header=TRUE)
print(data)

install.packages('FSA')

library(FSA)

Summarize(Attendees ~ Instructor,
          data = data)

Summarize(Attendees ~ Instructor + Location,
          data = data)

# PROBLEM 3
# PART A
# Stimpy had the higher mean number of attendees at 15.875 

# PART B
# Ren south had a higher mean number of attendees at 13.75
