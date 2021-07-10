# な組 Tech MTG
## Short Intro about the way to scikit-learn PR merge

---

## Summary
- linear regression
- linear_model in sklearn
- Implementation
  - Motivation (動機)
  - 
  - 
- Various method for constrained Ridge

---

## なにをやったの？
- sklearn.
- ごめんなさい、ちょっとした自慢話です。

---

## linear Regression
- 線形回帰(linear regression)
- 正則化項付きの線形回帰 (linear regression with regularizer)
  - Lasso (L1-regularized)
  - Ridge (L2-regularized)
  - ElasticNet (L1+L2)
- Why regularization?
  - To avoid overfitting to training data

---

## implementation in sklearn 
- sklearn.linear_model
  - LinearRegression
  - Lasso
  - Ridge
  - ElasticNet

---

## Motivation (動機)
- 王さんとやったお仕事
  - (金額に関係する)target variableを、
    user featureから線形回帰で予測したい
  - user featureの金額的価値を出すために
    coefficientを正(non-negative)にしたい
  - overfitting を避けるために regularizer を入れたい
    - でも 0 が多すぎるのは困る (Lassoはいやだ)
- sklearnを使おう!

---

## Positive argument in linear_model
- There is positive argument in LinearRegression
- Lassoはいやだ、Ridge を使おう
- あれ、positiveオプションが Ridge にだけない...
- How about ElasticNet? (and l1_ratio set to almost 0)
  - low reliability
- よく考えたら、前々職でも同じことがあった...
  - これは修正しないとね...

---

## Issue in sklearn repository
- There was Issue about ridge positive argument
  - example in physical science
  - This is not easy task because
    - constraints is not accepted in implemented method in Ridge
- lsq_linear
  - easy to use

---

## PR
- 遅いのが気になるね！と言われる。
  - 確かに遅いけど、まあいいかと思っていた。
- ベンチマークしたよ！と言われる。
  - とても素晴らしい benchmark

---

## 
- 送られてきた Benchmark Program
  - https://github.com/agramfort/benchmark_ridge_positive
- BenchOpt
  - Benchmark template for optimization problem
    - https://github.com/benchopt/template_benchmark
  - Structure
    - datasets
    - solver
- 
  - Coodinate Descent (CD)
  - Proximal Gradient Descent (PGD)
  - L-BFGS-B (nonlinear optimizer)

---

## Ridge Loss Function
- Loss Function

$$
L = \frac12  |A \boldsymbol{x} - y|^2_2 + \frac{\alpha}{2} |x|^2_2
$$

- Jacobian (gradient)

$$
L = A^T (A \boldsymbol{x} - y) + \alpha |x|
$$

---

##
- Coordinate Descent
  - ...
- Proximal Gradient Descent
  - Gradient Descent
  - Projectionする。
- L-BFGS-B
  - newton法を使う。
    - Hessianを推定しながら進む方法
    - 一次近似よりも速いと期待される。

- Sparse でも Dense でも L-BFGS-B が抜群に速い

---

