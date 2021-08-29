# な組 Tech MTG
## Causal Inference tutorial from KDD2021

---

## KDD2021 Tutorial
- [KDD2021](https://kdd.org/kdd2021/) (8/14-18) の面白かった [Tutorial](https://kdd.org/kdd2021/tutorials)
  - [Causal Inference and Machine Learning in Practice with EconML and CausalML](https://causal-machine-learning.github.io/kdd2021-tutorial/)
    - 機械学習を用いた因果推論(causal inference)とHands-on
      - 今回紹介します。
  - [Multi-Objective Recommendation](https://moorecsys.github.io/)
    - 多目的最適化(Multi-Objective Optimization)をRecommendationに適用する実例  
      weighted summartion と GAなどの huristics を使う方法がある。
  - [Mixed Method Development of Evaluation Metrics](https://kdd2021-mixedmethods.github.io/)
    - サーチエンジンやレコメンドにおいて、定量的な評価結果と  
      定性的な仮説検証/施策実行を組み合わせる Mixed Method の適用事例

---

## 因果推論(Causal Inference)の前提
- ある結果変数(outcome)がある
  - (例)ユーザがある商品を購入する, ある病気が回復する
- outcomeが改善する処置(treatment)を実施する。
  - (例)特定のWeb広告を見せる/見せない
- treatmentによりoutcomeは改善するかを知りたい！

![](./images/Causal_simple.png)

---

## 交絡因子(confounders)の存在
- 例えば、あるWeb広告を見た人は見ていない人に比べて  
  あるWebサービスへ登録率が高いとする。Web広告は登録率を上げた？
    - 正しいこともあるが、一般的には正しくない。
    - Correlation is not equal to causality.
- outcome, treatment 両方に影響を与える**交絡因子(confounders)**に注意。
  - 事前の engagement が高ければ広告も見やすいし  
    新しいサービスも使う傾向が強い（広告はなくてもよいかも？）

![](./images/Causal_basic_graph.png)

---

## 因果推論と効果的な費用投下
- 広告(treatment)が不要なケースがある
  - 広告がなくても商品を買う人がいる(Always-taker)
  - 広告があっても商品を買わない人がいる(Never-taker)
- 本当に広告が必要なユーザとは  **広告がないと商品を買わないが、**  
  **広告があると買う場合。**(Persuadable)
- 処置(treatment)があることで  結果変数(outcome)の期待値が上昇するか知りたい
  - この上昇を**処置効果(Treatment Effect)**または**アップリフト(Uplift)**という

![](./images/Causal_matrix.png)

---

## ランダム化比較実験 (RCT ; Randomized Controlled Trial)
- 処置への割り付けがランダムなら、交絡因子を無視できる
  - ランダム割り当てのA/Bテストがうまくいく理由

![](./images/Causal_randomized.png)

---

## ランダム実験ができない場合(1) : Unconfoundedness
- ランダム割り当てができなくても、交絡因子(Confounders)を  
  **すべて観測できていれば**、補正する方法がいくつかある
  - Classical Methods
    - 傾向スコア(propensity score) / IPW(inversed propensity weighting)
  - Machine Learning Methods
    - Meta Learner / Double Machine Learning

![](./images/Causal_unconfoundedness.png)

---

## ランダム実験ができない場合(2) : Instrument Variable
- 交絡因子がすべて観測できない場合でも
  操作変数という別の変数を仮定できる場合は、
  その変数を使った別の補正手法を使うことができる。
  - Tutorialでは事例が紹介されているが、ややこしいので今回は説明省略。

![](./images/Causal_IV.png)

---

## ランダム実験ができないケース
- いつもA/Bテストができればよいが、できない場合も多い
  - 割り付けがランダムにならない。
    - 割り付け通りにユーザが思い通りの行動をとってくれない。
  - 割り付けを考えずに収集されたデータを使って分析する
    - 観察研究(observational study)と呼ばれる

---
## 反実仮想(counterfactual)
- 処置をした人($T=1$)は、処置をした場合の結果($Y_1$)がわかる
- 処置をしなかった人($T=0$)は、処置をしなかった場合($Y_0$)の結果がわかる
- 全員に対する処置の効果は、全員について
  - 処置をした場合の結果がわかる必要がある。
  - 処置をしなかった場合の結果がわかる必要がある。
- 実験していない部分についても、結果がわかる必要がある。
  - 「もし実験していたらどのような結果が得られるだろう？」
    - **反実仮想(counterfactual)**

---

## 処置効果(treatment Effect)の計算
- 処置効果(treatment effect)の計算方法は複数ある
  - ATE : Average Treatment Effect
  - CATE : Average Treatment Effect
  - ITE : Indivisual Treatment Effect

---
## ATE (Average Treatment Effect)
- 実験をした全員について処置をした結果としなかった結果の差の期待値

---
## CATE (Conditional Average Treatment Effect)
- 実験をした人で条件を満たす人についての、平均処置効果

---
## ITE (Indivisual Treatment Effect)
- 個人ごとの $Y_1 - Y_0$ の期待値
  - どうやったらそんなものが計算できる？
    - Meta Learner または Double Machine Learning を使うことができる。

---
## Lift Chart


---
## Upliftを最大化する手順
- まず観測データを集める
- 適切にCausal Graphを設定し、Treatment$T$/Outcome$Y$/Confounders $X$を区別
- これに基づいて、Causal Modelを学習する
- ITEの高い順にソートした効果を出す
- 実運用に回す

---

## Tutorialで説明されている例
- 会員登録
  - 登録をコントロールできない
- Web広告の出稿
  - 不特定多数の人に見せることになるので、
- ..

---

## Causal Inferenceの道具
- 古典的手法
  - 傾向スコア法 (Propensity Score)
  - 傾向スコア逆数重みづけ (Inversed Propensity Score Weighing)
- 機械学習手法
  - Meta Learner
    - [CausalML](https://github.com/uber/causalml) (Uber) で  
      Meta Learnerの手法を多数実装している。
  - Double Machine Learning
    - [EconML](https://github.com/microsoft/EconML) (Microsoft) で
      Double Machine Learning の手法を実装している。

---

## Meta Learner の方法
- C Learner 
- 似たような考えで ...-Learnerが多数ある。

---

## Double Machine Learaning の方法
- 特徴
  - まったく違う発想を使う
  - 基本となる式
  - treatmentの推定式
    - つまり treatment が交絡因子によって依存することを
      モデル化する。
- それぞれ D, Y の推定式は任意の方法を使ってもよいとされる。
- さらに treatment effect にも任意の式が使える。
  - 理論的裏付けも多数ある。

---

## CATEの評価
- C-Learner の場合
- Double Machine Learning の場合
  - R-Learner というものとににていて。

---

## Instrument Variableが存在する場合
- 2SLS または DR IV という方法のどちらかがある。
  - ちょっとややこしい。

---

## AUCCという評価

---

## サンプル

---

## 実業務で利用することを考える場合
- 一部のユーザに対して実施したモデルで CATE推定用のモデルを構築する
- Upliftが最大となるところで、

---

## Tutorialガイド
- Tutorialを見てみよう
  - CausalMLの例はとても分かりやすい : Web広告
  - EconMLの例は難しい。

---

## 印象
- ただし実際には難しい
  - 因果グラフを事前に洗い出しておく必要あり。
    - 観測値と制御因子以外の交絡因子・操作変数などを
      洗い出しておく必要あり。
  - 手法の正しい理解が必要
