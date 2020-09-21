

library(broom)
library(estimatr)

# mtcarsを使った推定
lmfit <- lm(mpg ~ wt, mtcars)

# オブジェクトのクラス確認
class(lmfit)

# サマリー
summary(lmfit)

# 整然化された出力
tidy(lmfit)


# augmentで予測値などを出力
augment(lmfit)

# glanceでモデルサマリーを出力
glance(lmfit)


# mtcarsを使った推定
lmrob <- lm_robust(mpg ~ wt, mtcars)

tidy(lmrob)
