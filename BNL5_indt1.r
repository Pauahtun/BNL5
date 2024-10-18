#---第2部Stan入門編---第5章基本的な回帰とモデルのチェック---5.2二項ロジスティック回帰
#---Jiro Nagao

#---データ導入

#---2024-10-18-Wednesday

#-------------------------------------------------------------------------------
#setwd("C:/Users/njiro/OneDrive/O_DRV/WD/R_WD/lsn/matsu/MLR5")
setwd("C:/Users/njiro_o08316b/OneDrive/O_DRV/WD/R_WD/lsn/matsu//BNL5")
rm(list = ls())
wd <- getwd()

#-------------------------------------------------------------------------------
#---パッケージ読込
library(tidyverse)
#library(ggplot2)
#library(GGally)
#library(ellipse)
#library(gridExtra)
#library(rstan)
#library(ggmcmc)

#-------------------------------------------------------------------------------
indt <- paste0(wd, "/input")
outdt <- paste0(wd, "/output")
mdl <- paste0(wd, "/model")
gra <- paste0(wd, "/graph")

#-------------------------------------------------------------------------------
#---csv読込関数
rd_csv <- function(path, filename){
  df <- read.csv(
    file = paste0(
      path,
      "/",
      filename
    ),
    header = TRUE
  )
  return(df)
}


#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
#---main program
#-------------------------------------------------------------------------------
#---初期設定
#set <- setting()

#---csv読込
ipnm1 <- indt
ifnm1 <- "data-attendance-2.txt"
df <- rd_csv(ipnm1, ifnm1)
#head(df)

#-------------------------------------------------------------------------------
