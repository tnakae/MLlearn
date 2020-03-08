# 前提
- CGSにおいて、updateするのは $\boldsymbol{z}$
- 通常は、ハイパーパラメータである $\alpha, \beta$ は一様で
  アップデートも行わない

# 提案
- $\alpha, \beta$ が非一様であればどうなるか？
- 初期値を適当に決めても、適切な値にアップデートされるようにできないか？

# 考え方
- CGSで $\boldsymbol{z}$ を決める
- そのあとに、$\boldsymbol{\alpha} = \{\alpha_k\}$ を更新する

# ハイパーパラメータの最尤推定
CGSで発生させた $\boldsymbol{z}$ から次の尤度を最大化する$\boldsymbol{\alpha}$ を求める。

$$
P(\boldsymbol{z}|\boldsymbol{\alpha}) =
  \prod_d \int d \boldsymbol{\theta}_d
    P(\boldsymbol{z}_d | \boldsymbol{\theta}_d)
    P(\boldsymbol{\theta}_d | \boldsymbol{\alpha})
$$

ここで、$P(\boldsymbol{z}_d | \boldsymbol{\theta}_d)$は
多項(Multinomial)分布であり、

$$
P(\boldsymbol{z}_d | \boldsymbol{\theta}_d)
  = \prod_k \theta_k^{N_{dk}}
$$

$P(\boldsymbol{\theta}_d | \boldsymbol{\alpha})$ は
ディリクレ(Dirichlet)分布であり、

$$
P(\boldsymbol{\theta}_d | \boldsymbol{\alpha})
  = \frac{\Gamma(\sum_k \alpha_k)}{\prod_k \Gamma(\alpha_k)}
    \prod_k \theta_k^{\alpha_k - 1}
$$

これらを代入すると、

$$
\begin{aligned}
  P(\boldsymbol{z}|\boldsymbol{\alpha})
  =&
    \prod_d \int d \boldsymbol{\theta}_d
    \prod_k \theta_k^{N_{dk}} \cdot
      \frac{\Gamma(\sum_k \alpha_k)}{\prod_k \Gamma(\alpha_k)}
          \prod_k \theta_k^{\alpha_k - 1} \\
  =&
    \prod_d
    \frac
      {\Gamma(\sum_k \alpha_k)}
      {\prod_k \Gamma(\alpha_k)} \cdot
    \frac
      {\prod_k \Gamma(N_{dk} + \alpha_k)}
      {\Gamma(N_d + \sum_k \alpha_k)}
    \int d \boldsymbol{\theta}_d
      \frac
        {\Gamma(N_d + \sum_k \alpha_k)}
        {\prod_k \Gamma(N_{dk} + \alpha_k)}
        \prod_k \theta_k^{N_{dk} + \alpha_k - 1} \\
  =&
    \prod_d
    \frac
      {\Gamma(\sum_k \alpha_k)}
      {\prod_k \Gamma(\alpha_k)} \cdot
    \frac
      {\prod_k \Gamma(N_{dk} + \alpha_k)}
      {\Gamma(N_d + \sum_k \alpha_k)}
  
\end{aligned}
$$
最後の式は、ディリクレ分布の積分が1になることを使った。

# おさらい ガンマ関数
さらりとつかったガンマ関数 $\Gamma(x)$ とはいったい何？
- $\displaystyle{\Gamma(x) = \int_0^{\infty} t^{x-1}e^{-t}dt}$ ... なんか積分とかいやだ。。
- $x$ が整数なら $\Gamma(x) = (x-1)!$ ... つまり階乗の一般化、と思えば怖くない？

階乗なので、$x$が大きくなるとものすごく大きくなる。
- 機械学習の数値計算では、通常 $\log{\Gamma(x)}$ を使う。
- Pythonでは、`math.lgamma` や `scipy.special.gammaln` が使える。

$\log{\Gamma(x)}$ の微分 $\Psi(x) = \displaystyle{\frac{d\log{\Gamma(x)}}{dx}}$ をディガンマ関数(digamma function)と呼ぶ
- 変分計算ではなぜかよく出てくる。$\Psi$ とか記号が悪魔チックだし、名前も超怖い。
- ただし Pythonでは `scipy.special.digamma` がいるし、
  他のライブラリでも大抵便利関数があり、何も恐れることはない。

# シンプルな下限を探そう
- 次の値を $\boldsymbol{\alpha}$ について最大化すれば良いのであった。

$$
P(\boldsymbol{z}|\boldsymbol{\alpha}) = \prod_d
  \frac
    {\Gamma(\sum_k \alpha_k)}
    {\prod_k \Gamma(\alpha_k)} \cdot
  \frac
    {\prod_k \Gamma(N_{dk} + \alpha_k)}
    {\Gamma(N_d + \sum_k \alpha_k)}
$$

- **右辺が激しい。** 何とかシンプルにならないだろうか？
- 作戦
  - もう少しシンプルな式の形の下限を見つける。
  - 下限を最大化する。
    - でもこれは本当の最適値ではないのでそのポイントで下限を見つける
    - 下限を最大化
      - ...

# 下限についての定理 2つ
- Minka (2000)

$$
\begin{aligned}
\log \Gamma (x) - \log \Gamma(x + a) \ge &
  \log \Gamma(x_0) - \log \Gamma(x_0 + a) +
  (\Psi(x_0 + a) - \Psi(x_0))(x_0 - x) \\
\log \Gamma (x + a) - \log \Gamma(x) \ge &
  \log \Gamma(x_0 + a) - \log \Gamma(x_0) +
  x_0 (\Psi(x_0 + a) - \Psi(x_0))(\log x - \log x_0) \\
\end{aligned}
$$

- 思い出そう
  - $\Gamma(x)$ はガンマ関数だった。
  - $\Psi(x)$ はディガンマ関数で、 $\Psi(x) = \frac{d}{dx} \log{\Gamma(x)}$
- やや唐突感があり一体なんのことやら、という気もする。意味は後でわかる。
  - 雰囲気としては、$x$ についての関数を $x_0$ の周りで
    1次のTaylor展開をしているような下限の関数形を見つけている。
    やや神がかり的であり、意味を深く考えないほうがいいかも。
  - 証明を追うより、子供とのふれあいの時間を優先した。

# 下限の傾向
- 少しはなるほど感を出してみる。
- Part1
  - $x_0$ の周りで直線で近似していることに相当
- Part2
  - $x_0$ の周りで $\log x$ として近似していることに相当。
  - あとでs

# 
- 対数尤度

$$
\begin{aligned}
  \log P(\boldsymbol{z}|\boldsymbol{\alpha})
  =&
    \log \prod_d
    \frac
      {\Gamma(\sum_k \alpha_k)}
      {\prod_k \Gamma(\alpha_k)} \cdot
    \frac
      {\prod_k \Gamma(N_{dk} + \alpha_k)}
      {\Gamma(N_d + \sum_k \alpha_k)} \\
  =&
    \sum_d \left[
      \log \Gamma(\alpha) - \log \Gamma(N_d + \alpha) +
      \sum_k \{
        \log \Gamma(N_{dk} + \alpha_k) - 
        \log \Gamma(\alpha_k)
      \}
    \right]
\end{aligned}
$$

- 下限の先ほどの式を、前半と後半にそれぞれ使う

$$
\begin{aligned}
  \log P(\boldsymbol{z}|\boldsymbol{\alpha})
   \ge &
    \sum_d [
      \log \Gamma(\alpha) - \log \Gamma(N_d + \alpha) +
      \{
        \log \Gamma(N_{dk} + \alpha_k) - 
        \log \Gamma(\alpha_k)
      \} (\alpha - \alpha^{*}) \\
      &+ \sum_k \{
        \log \Gamma(N_{dk} + \alpha_k) - 
        \log \Gamma(\alpha_k) + 
        \alpha_k \{
          \log \Gamma(N_{dk} + \alpha_k) - 
          \log \Gamma(\alpha_k)
        \} (\log \alpha_k^* - \log \alpha_k)
      \}] \\
  =&
    \sum_d [
      \{
        \log \Gamma(N_{dk} + \alpha_k) - 
        \log \Gamma(\alpha_k)
      \} (- \sum_k \alpha_k^{*}) \\
      &+ \sum_k \{
        \log \Gamma(N_{dk} + \alpha_k) - 
        \log \Gamma(\alpha_k) + 
        \alpha_k \{
          \log \Gamma(N_{dk} + \alpha_k) - 
          \log \Gamma(\alpha_k)
        \} (\log \alpha_k^* - \log \alpha_k)
      \}]       
\end{aligned}
$$
