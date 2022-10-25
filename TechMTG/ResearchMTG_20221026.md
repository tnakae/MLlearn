<style>
img[alt~="center"] {
  display: block;
  margin: 0 auto;
}
</style>

<!-- paginate: true -->
<!-- footer: Research MTG : 2022-10-25 -->

# Research MTG
## 2022-10-26 / nakae
- 今回の対象論文
  - [Adversary or Friend? An adversarial Approach to Improving Recommender Systems](https://dl.acm.org/doi/abs/10.1145/3523227.3546784)
  - Pannaga Shivaswamy, Dario Garcia-Garcia (RecSys '22)

---

## Summary
- 公平性を考慮するレコメンドモデルで、従来精度を改善。
- 公平性の考慮にARL(Adversarially Reweighted Learning)という手法を適用
  - このアルゴリズムが面白いのでちょっと長めに説明します。

---

## よく出てくる公平でない例
- 「CEO」のGoogle画像検索結果 → 男性に偏る
  - 学習データの中に、男性のCEO のデータが非常に多いから
  - 学習データが特定の属性に偏る場合に起こりがちである。

![width:900px center](./images/Adversarial_CEO.png)

---

## 公平性を考慮した機械学習の問題点
- 公平性(fairness)を考慮した機械学習アルゴリズムはとても多い
  - ただし大抵の場合、その属性が手に入ることが前提になっている。
- にもかかわらず、**公平性を考慮すべき属性は収集が難しくなっている**
  - 性別 / 人種 など。
  - 収集に厳しい規制がある地域もある (EUのGDPRなど)

---
## 公平性
- 幸福/公平性(fairness)の定義はいっぱいある
  - ベンサムの功利主義(utilitarianism)
    - 最大多数の最大幸福 (the greatest happiness of the greatest numbers)
    - **利得の合計を最大化**するのがもっともよいとされる。
  - ロールズの公平性 (Rawlsian fairness)
    - 最も不幸な人の幸福度が最大化されることが公平である。
    - **Max-Min戦略** (利得が最小になる集団で、
      利得を最大化する)ことが良いこととされる。
      - 今回はこちらが大事

---

## ARL
- ARL (Adversarially Reweighted Learning)
  - [NeurIPS (2020) : Fairness without Demographics through Adversarially Reweighted Learning](https://proceedings.neurips.cc/paper/2020/hash/07fc15c9d169ee48573edd749d25945d-Abstract.html)
  - **公平性を考慮すべき属性が手に入らない前提**で、
    敵対的学習(Adversarial learning) を使って公平な学習ができる手法
    - 性別がなくても、男性/女性に公平な学習結果を担保できる！
- 敵(adversary)の考え方
  - 画像生成など : 敵＝**せっかく作ったニセモノの判別する悪いやつ。**
  - ARL : 敵＝**判別が難しいサンプルだけを見つける悪いやつ。**

---

## 公平でない学習の例とARL
- 例えば Non-Protected=男性, Protected=女性
- Positive/Negativeを判別したいが、男性が強くて女性サンプルで判別失敗
- ARLを使えば、判別失敗しているところをうまく判別できる
  (=computationally identifiable)

![width:600px center](./images/Adversarial_ARL_scatter.png)

---

## ARL:判別モデルの例
- 通常の学習
$$
\min_w \frac1n \sum_{i=1}^n
  l(x_i, y_i; w) + \frac{C}2 \Vert w \Vert^2 
$$

---

## ARL:判別モデルの例
- ARL (Adversarially Reweighted Learning)
$$
\min_w \max_a \frac1n \sum_{i=1}^n
  \sigma[a^T \phi(x_i, y_i)]l(x_i, y_i; w)/z
  + \frac{C}2 \Vert w \Vert^2 - \frac{B}2 \Vert a \Vert^2 
$$
  - $\sigma[...]$ は logistic関数(0-1の連続値を取る)
  - $z$ は、正規化定数

### 学習ステップ
- 敵($a$) : 損失が大きくなるような $a$ を見つける (超いじわるなやつ)
- 味方($w$) : 損失が小さくなるように $w$ を更新する (がんばれ！)

---

## 今回の論文の考え方
- レコメンドは多数派に有利な学習が行われがち
  - 少数グループのUser/Itemには不利なレコメンド結果と
    なっている傾向がある
  - でも少数グループはどれか直接はわからない。
- これを解決するために ARL を適用しよう！という発想
  - 性別がわからない場合の公平性学習と同じ、と考えよう。

---

## レコメンドモデルへの適用

EASE を対象とする (SLIMのようなモデル)

$$
\begin{aligned}
\min_{W} & \frac1{mn} \sum_{i=1}^{m} \sum_{j=1}^{n}
  (X_{ij} - [ XW ]_{ij})^2 + \frac{C}2 \Vert W \Vert_F^{2} \\
& \textrm{s.t.} \quad \textrm{diag}(W) = 0
\end{aligned}
$$

---
## EASE に ARL を適用する

$$
\begin{aligned}
\min_{W} \max_{A} & \sum_{i=1}^{m} \sum_{j=1}^{n}
  (X_{ij} - [ XW ]_{ij})^2 \sigma(X_i A) / z
  + \frac{C}2 \Vert W \Vert_F^{2} - \frac{B}2 \Vert A \Vert_F^{2} \\
& \textrm{s.t.} \quad \textrm{diag}(W) = 0
\end{aligned}
$$

### 補足
- $X_i$ : User$i$の接触アイテムvector
- $A$ : 敵が設定するアイテムごとの重み
  - 損失が大きくなるように調整する (超いじわるなやつ)

---

![width:600px center](./images/Adversarial_Algo1.png)

- ただし実はこれはうまくいかない...
  - 敵側のloss部分をnDCGに変更するアルゴリズム(R-LARM)だと精度改善

---

![width:600px center](./images/Adversarial_results.png)
