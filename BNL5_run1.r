#---第2部Stan入門編---第5章基本的な回帰とモデルのチェック---5.2二項ロジスティック回帰
#---Jiro Nagao

#---モデルラン

#---2024-10-24-Wednesday

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
library(rstan)
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
  par <- c("b1", "b2", "b3")
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
#---stan出力記録関数
wr_stan <- function(path, filename){
  save.image(
    file = paste0(
      path,
      "/",
      filename
    )
  )
}

#-------------------------------------------------------------------------------
#---stanコンパイル関数
cmpl_stan <- function(path, filename){
  df <- stan_model(
    file = paste0(
      path,
      "/",
      filename
    )
  )
  return(df)
}

#-------------------------------------------------------------------------------
#---パラメータリスト設定関数
set_par <- function(){
  par <- c("b1", "b2", "b3")
  return(par)
}

#-------------------------------------------------------------------------------
#---パラメータ初期設定関数
set_parini <- function(){
  par_ini <- list(
    b1 = runif(1, -10, 10),
    b2 = runif(1, 0, 10),
    b3 = runif(1, 0, 10),
  )
  return(par_ini)
}

#-------------------------------------------------------------------------------
#---stanサンプリング関数
smp_stan <- function(model, data, pars, parameter_list, seed, chain, iter, warmup, thin){
  fit <- sampling(
    model,
    data = data,
    #pars = pars,
    #init = function(){parameter_list},
    seed = seed,
    chain = chain,
    iter = iter,
    warmup = warmup,
    thin = thin
  )
  return(fit)
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

#-------------------------------------------------------------------------------
data <- list(
  N = nrow(df),
  A = df$A,
  Score = df$Score / 200,
  M = df$M,
  Y = df$Y
)

#-------------------------------------------------------------------------------
#---stanモデルの実行
#---stanファイルのコンパイル
ipnm2 <- mdl
ifnm2 <- "BNL5_model1.stan"
stanmodel <- cmpl_stan(ipnm2, ifnm2)

#---サンプリング
fit <- smp_stan(
  stanmodel, 
  data = data, 
  #pars = pars, 
  #parameter_list = par_ini, 
  
  chain = set$chain, 
  seed = set$seed, 
  iter = set$iter, 
  warmup = set$warmup, 
  thin = set$thin
)

#---サンプル抽出
fit
ms <- rstan::extract(fit)
#head(ms)

#-------------------------------------------------------------------------------
#---stan結果出力
opnm1 <- outdt
ofnm1 <- "BNL5_result.RData"
wr_stan(opnm1, ofnm1)
fit

