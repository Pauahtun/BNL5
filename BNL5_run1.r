#---第2部Stan入門編---第5章基本的な回帰とモデルのチェック---5.2二項ロジスティック回帰
#---Jiro Nagao

#---モデルラン

#---2024-10-21-Monday

#-------------------------------------------------------------------------------
#setwd("C:/Users/njiro/OneDrive/O_DRV/WD/R_WD/lsn/matsu/MLR5")
setwd("C:/Users/njiro_o08316b/OneDrive/O_DRV/WD/R_WD/lsn/matsu//BNL5")
rm(list = ls())
wd <- getwd()

#-------------------------------------------------------------------------------
#---パッケージ読込
library(tidyverse)
#library(ggplot2)
library(GGally)
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
#---初期設定関数
setting <- function(){
  set <- data.frame(
    seed = 123,
    chain = 3,
    iter = 1000,
    warmup = 200,
    thin = 2
  )
  return(set)
}

#-------------------------------------------------------------------------------
#---パラメータリスト設定関数
set_par <- function(){
  par <- c("b1", "b2", "b3", "sigma")
  return(par)
}

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
set <- setting()
pars <- set_par()

#---csv読込
ipnm1 <- indt
ifnm1 <- "data-attendance-2.txt"
df <- rd_csv(ipnm1, ifnm1) |> 
  select(-1)

head(df)
