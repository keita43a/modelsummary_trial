# modelsummary::msummary() trial
# Author: Keita Abe

# Create: May 28, 2020

# Trial code of {modelsummary} package
# modelsummaryパッケージを使ってみたコードです

# package load
pacman::p_load(
  tidyverse,
  modelsummary,
  knitr,
  kableExtra,
  gt,
  estimatr
)

# run model. 
# use mtcars data as example

reg <- lm(mpg ~ cyl+disp, mtcars)
msummary(reg)

regs <- list()
regs[['Model A']] <- lm(mpg ~ cyl+disp, mtcars)
regs[['Model B']] <- lm(mpg ~ cyl+disp+hp, mtcars)


msummary(regs)


# text output: テキスト
msummary(regs, 'markdown')

# table apparence: テーブル修飾
msummary(regs, output = 'html')%>%
  gt::tab_style(style = cell_fill(color = "lightcyan"),
            locations = cells_body(rows = 3)) %>%
  gt::tab_style(style = cell_text(weight = "bold"),
            locations = cells_body(rows = 3))




# latex output: テックス出力
msummary(regs, 'latex')


# standard errors: 標準誤差など
msummary(regs, statistic = 'std.error') # 標準誤差
msummary(regs, statistic = 'p.value')   # p値
msummary(regs, statistic = 'statistic') # t統計量
msummary(regs, statistic = 'conf.int', conf_level = .99) # 99% 信頼区間


# title/memo タイトルとメモ

msummary(regs,
         title = "表１：mtcarsの結果",          # Title
         notes = list('メモ１, 南無妙法蓮華経',    # Notes
                      'Memo 2, namumyo horengekyo'))

# change variable names : 変数名変更
var_nam = c("mpg" = "Mile per gallon", "(Intercept)" = "Constant",
            "cyl" = "Cylinder", "disp" = "Displacement",
            "hp" = "Horse Power")

msummary(regs, coef_map = var_nam)


# model fit モデルフィット

msummary(regs, gof_omit = "R2|AIC|BIC")

# p-star

msummary(regs, stars = TRUE) # default デフォルト, `* p < 0.1, ** p < 0.05, *** p < 0.01`
msummary(regs, stars = c("*" = .05, "**" = .01, "***" = .001)) # custom カスタム

# digits

msummary(regs, fmt = '%.2f') # second decimal point 小数点第二位


# add rows 行の追加

row1 <- c('FE 1', 'No', 'No')
row2 <- c('FE 2', "No","No")
msummary(regs, add_rows = row2)


# estimatr::lm_robust

regs_rob <- list()
regs_rob[["Model A rob"]] <- lm_robust(mpg ? cyl+disp, 
                                       se_type = "stata",
                                       fixed_effects = ? vs + am,mtcars)
regs_rob[["Model B rob"]] <- lm_robust(mpg ? cyl+disp+hp, 
                                       se_type = "stata",
                                       fixed_effects = ? vs + am,mtcars)

msummary(regs_rob)

