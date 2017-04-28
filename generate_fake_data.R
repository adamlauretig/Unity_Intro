# Generate fake data for ASC Unity demo
# Author: Adam Lauretig
# 2017
set.seed(614)

fake_data <- sample(letters, size = 10000, replace = TRUE)
save(fake_data, file = "~/data/Unity_intro/fake_data.rdata")