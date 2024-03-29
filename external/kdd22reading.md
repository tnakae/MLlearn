<!--
marp: true
theme: gaia
paginate: true
size: 4:3
-->

<style>
@import url('https://fonts.googleapis.com/css?family=Noto+Sans+JP');

section {
  background-color: white;
  font-size: 140%;
  font-family: "Noto Sans JP", "Meiryo";
  color: #444444;
  padding: 40px 40px 50px 50px;
  background-image: url(./images/bizreach.png);
  background-repeat: no-repeat;
  background-size: 200px;
  background-position: right 50px top 20px;
}

footer {
  box-sizing: border-box;
  border-top: 3px solid darkred;
}

section.top h1,
section.top h2 {
  text-align: center;
}

section.top h1 {
  font-size: 1.2rem;
  margin-top: 220px;
  margin-bottom: 60px;
}

section.top h2 {
  color: #777777;
  font-size: 0.75rem;
  margin-top: 0px;
}

section.normal h1,
section.normal h2,
section.normal h3,
section.normal h4 {
  margin-top: -25px;
  margin-bottom: -10px;
  margin-left: -50px;
  margin-right: -50px;
  padding-left: 40px;
  padding-bottom: 10px;
  border-bottom: 3px solid darkred;
}

section.normal h1 {
  font-size: 1.15rem;
}

section.normal h2 {
  font-size: 1.05rem;
}

section.normal h3 {
  font-size: 1.01rem;
}

section.normal h4 {
  font-size: 1rem;
}

img[alt~="center"] {
  display: block;
  margin: 0 auto;
}
</style>

<!-- paginate: false -->
<!--_class: top-->
# Non-stationary A/B Tests
## KDD22 関連有志読み会<br>株式会社ビズリーチ 中江 俊博<br>2022-11-24

---

<!-- paginate: true -->
<!-- footer: KDD22 関連有志読み会 / Non-stationary A/B Tests -->
<!--_class: normal-->

## 自己紹介
- 中江 俊博 (なかえ としひろ)
  - 株式会社ビズリーチ
    - リクルーティングプロダクト本部
      プラットフォーム開発部
      AI1グループ Mgr
- 経歴
  - NTTデータ数理システム(-2018)  
    - データ分析コンサルタント
  - TripleW(2018-2019)
    - 排尿予測モデル実装
  - ビズリーチ (2019-現職)
    - 推薦モデルなどの機械学習関連の
      実装の統括担当

![bg right:38% width:280px](./images/photo.jpg)

---

<!--_class: normal-->

## 今回対象となる論文

- [Non-stationary A/B Tests](https://dl.acm.org/doi/10.1145/3534678.3539325) (KDD 2022)
  - Yuhang Wu, Zeyu Zheng+
  - University of California, Berkeley と Amazon の混成チーム
- 要旨
  - A/Bテストの対象となるmetricsが、定常性を満たさない場合に、
    A/Bテストの推定値の分散が大きくなるケースがある。
  - 非定常であるmetricsに対して、A/Bテストの推定値の分散を
    低減させる方法を提案

---

<!--_class: normal-->

## 問題意識
- A/Bテスト対象のメトリクスの時系列変動が非定常である場合
  A/Bごとにメトリクスの平均の差を出すと分散が著しく大きくなる。
  - 図(論文Figure1)のように日内変動、曜日変動をするようなケース
- 変動要素が曜日などに依存することが既知であれば層別化/回帰すればよい
- では、単純な周期性に還元できない非定常の場合どうしたらよい？
  - 時系列を等間隔に分割して層別化すればよい！(今回の提案)

![center width:600px](./images/NonStationary_Example.png)

---

<!--_class: normal-->

## 前提(1)
- 対象となるサンプルは 平均 $\lambda(t)$ の Poisson で到着
- Treatment/Control の割り当ては、確率 $p(t)$ の Bernoulli で決める。
  - このようにして集められたサンプルが手元にあると考える。

![center width:500px](./images/NonStationary_arrival.png)


---

<!--_class: normal-->

## 前提(2)
- Treatment/Control の時刻$t$でのメトリクス $Y_1(t), Y_0(t)$は、
  時刻$t$に依存して平均/分散が変動しているとする。

![center width:500px](./images/NonStationary_timeseries.png)

- A/Bテストにおける推定値

$$
\begin{aligned}
\alpha
 &= \mathbb{E}[Y_1(\tau) -Y_0(\tau)] \\
 &= \int_0^T [\mu_1(t) - \mu_0(t)] f(t) dt
\end{aligned}
$$

---

<!--_class: normal-->

## サンプル事後層別化
- Treatmentへの割り当て確率$p$が、時刻に依存せず固定である前提で、
  サンプルを$n$個集めた後で、均等に $k(n)$ 個の区間に分割
![center width:500px](./images/NonStationary_sps.png)

- そのあとで、層別平均の差の重み付き和をとる
  (Sample-based Post Stratification ; SPS)

$$
\hat{\alpha}_{\textrm{sps}}
 = \sum_{j=1}^{k(n)} \frac{|S_j|}{n}
  (
    \frac{\sum_{i\in S_{j,1}} y_i}{|S_{j,1}|} -
    \frac{\sum_{i\in S_{j,0}} y_i}{|S_{j,0}|}
  )
$$


---

<!--_class: normal-->

## サンプル事後層別化の分散
- Theorem 3.1
  - もし $\displaystyle \lim_{n \to +\infty} k(n) = +\infty$ でかつ $k(n) = o(n^{\frac12})$ なら
$$
\sqrt{\bar{\lambda}}(\hat{\alpha}_{\textrm{sps}} - \alpha) \overset{d} \to
  {\mathcal{N}(0, V_{\textrm{sps}})} \textrm{, as} \hspace{0.5em} \bar{\lambda} \to +{\infty}
$$
- ここで、分散 $V_{\textrm{sps}}$については
$$
V_{\textrm{sps}} =
  \textrm{Var}[\mu_1(\tau) - \mu_0(\tau)] +
  \mathbb{E}[
    \frac{\sigma_1^2(\tau)}{p} + \frac{\sigma_0^2(\tau)}{1-p}
  ]
$$

- ちなみに、naiveなA/B比較(サンプル平均の差)の分散と比較する

$$
V_{\textrm{naive}} =
  \frac{\textrm{Var}[\mu_1(\tau)]}{p} +
  \frac{\textrm{Var}[\mu_0(\tau)]}{1-p} +
  \mathbb{E}[
    \frac{\sigma_1^2(\tau)}{p} + \frac{\sigma_0^2(\tau)}{1-p}
  ]
$$

- **SPSは$\mu$の差の分散、naiveは分散の重み付き和になっている**



---
<!--_class: normal-->

## 何を言っているのか？

- naiveの分散は、それぞれの時系列の分散の和 + $\varepsilon$の分散
- SPSの分散は、その時点における平均の差の分散 + $\varepsilon$の分散

![center width:550px](./images/NonStationary_variance.png)

---

<!--_class: normal-->

## 具体例
- 線形に変化するような場合 ($\sigma_1, \sigma_2$ も同様に線形を仮定)

$$
\begin{aligned}
\mu_1(t) = a_1 + b_1 t \\
\mu_2(t) = a_0 + b_0 t
\end{aligned}
$$

- 推定値の分散
$$
\begin{aligned}
V_{\textrm{naive}}
  &= (b_1^2 + b_0^2) \frac{T^2}6 + [\sigma \textrm{に起因する分散}] \\
V_{\textrm{sps}}
  &= (b_1 - b_0) ^ 2 \frac{T^2}{12} + [\sigma \textrm{に起因する分散}]
\end{aligned}
$$

$$
\begin{aligned}
\frac{V_{\textrm{sps}}}{V_{\textrm{naive}}}
  \approx \frac{(b_1 - b_0) ^ 2}{2(b_1^2 + b_0^2)}
\end{aligned}
$$

- $b_1, b_0$ が大きく、かつ値が非常に近い場合は、
  sps は naive に対する改善が非常に大きい

---

<!--_class: normal-->

## もっと一般的な状況
- Treatment への割り当て確率 $p(t)$ が時刻によって異なる場合
  **もし、各時点における到着密度 $f(t)$ が正確にわかるのであれば**
  $\alpha_{\textrm{dps}}$ は、サンプル数増加で真の推定値 $\alpha$ に(確率)収束する。
  - dps = De-biased Post Stratification

$$
\begin{aligned}
\hat{\alpha}_{\textrm{dps}}
 &= \sum_{j=1}^{k(n)} q_j
  (
    \frac{\sum_{i\in S_{j,1}} y_i}{|S_{j,1}|} -
    \frac{\sum_{i\in S_{j,0}} y_i}{|S_{j,0}|}
  ) \\
\textrm{here} \quad q_j
 &= \int_{\frac{j-1}{k(n)}T}^{\frac{j}{k(n)}T} f(t)dt
\end{aligned}
$$

- dpsでは、各時点でA/Bテストに含める確率もバラバラでもよいらしい。
- ただし、$f(t)$ が正確にわかるという前提を一般の状況で
  仮定するのは難しいと思われる
  - このdpsについては、論文での記載はややあいまい。
    もう少しちゃんと書いてほしい (掘り下げる余地ありとみるべきか)


---
<!--_class: normal-->

## 別の発想 : 到着順に割り当てる工夫
- $p=1/2$で割り当てるのであれば、到着順にA/B/A/B/.. と
  割り当てるのもよさそう！
  - ほぼ同一時刻で対になるサンプルを生成しているのと
    同じとみることができるから。
- この発想で、Treatmentへの割り当て確率が有理数 $p=u/w$ で、
  出現する $w$ 個ごとに Treatment を $u$ 個割り当てた場合の
  A/Bテストの平均の差 $\hat{\alpha}_{\textrm{tr}}$ についても sps と同程度の分散になる！
  - tr : Time-grouped Randomization

$$
V_{\textrm{tr}} =
  \textrm{Var}[\mu_1(\tau) - \mu_0(\tau)] +
  \mathbb{E}[
    \frac{\sigma_1^2(\tau)}{p} + \frac{\sigma_0^2(\tau)}{1-p}
  ]
$$

---
<!--_class: normal-->

## 実験結果
- 7日間で時刻/曜日変動があるようなダミーデータを
  Eコマースの実績データをもとに生成
  - A/B比率 $p = 1/2$ とする。
- 手法
  - naive : A/B群の平均の差
  - psf : 曜日ごと平均の差の平均
  - sps, tr : 提案法
- 結果

![center width:500px](./images/NonStationary_result.png)

---
<!--_class: normal-->

## まとめ
- 一般的な非定常の時系列となるA/Bテストで分散が小さくなる
  サンプル事後層別化 sps = Sample-based Post Stratification を考案
  - 単なる層別化と比較しても分散が小さくなる
- A/B群への割り当てを到着順に割り当てるような方法
  (tr = Time-grouped randomization)でも sps と同等の分散となる
