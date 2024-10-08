#mengimport data dari URL
library(readr)
pef <- read_csv("https://raw.githubusercontent.com/dwi-agustian/biostat/main/pef.csv")

w5 <- read_csv("https://raw.githubusercontent.com/dwi-agustian/biostat/main/w5.csv")

library(dplyr)

#memilih variable yang akan dianalisis
pef = select(pef, pidlink,age,height,pef,us09a,us09b,us09c)

w5 = select(w5, pidlink,sc01_14_14,sc02_14_14,sc03_14_14,sex,hyper,heartprob,stroke,Asthma,br_diff,br_wheez,br_fast,cough,dry_cough,phlgm_cough,bloody_cough,hosp,outp,agegr)

#melihat deskriptif statistik dari semua variable di data set
summary(pef)
summary(w5)

#memilih observasi
#memilih observasi dimana data height tidak missing (komplit), dan data Age tidak ada yang outlier
pef = filter(pef, age != 998)

pef = filter(pef, !is.na(height))

w5 = filter (w5, !is.na(pidlink))

w5 = filter (w5, !is.na(sex))

# check jumlah obs pidlink yang unik
n_distinct(pef$pidlink)

n_distinct(w5$pidlink)

#Find duplicated Pidlink
pef %>% 
  count(pidlink) %>% 
  filter(n > 1)

w5 %>% 
  count(pidlink) %>% 
  filter(n > 1)

# Remove duplicated rows based on pidlink
w5 = w5 %>% distinct(pidlink, .keep_all = TRUE)

pef = pef %>% distinct(pidlink, .keep_all = TRUE)

#melakukan check klasifikasi variabel
str(pef)
str(w5)

# Convert character to number: pidlink
w5 <- w5 %>%
  mutate(pidlink_num = as.numeric(pidlink))

w5 <- w5 %>%
  mutate(pidlink_num = as.integer(pidlink))

#mengcopy paste variable pidlink asli
w5$pidlink_chr = w5$pidlink

#mereplace pidlink dengan versi int(num)
w5$pidlink = w5$pidlink_num


#combining dataset (menggabungkan data)
# menggabungkan variables dengan common variable
w5_pef_c_lj = left_join(w5, pef, by = "pidlink")
w5_pef_c_rj = right_join(w5, pef, by = "pidlink")
w5_pef_c_ij = inner_join(w5, pef, by = "pidlink")
w5_pef_c_fj = full_join(w5, pef, by = "pidlink")

summary(w5_pef_c_ij)
summary(w5_pef_c_fj)