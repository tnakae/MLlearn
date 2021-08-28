# な組 Tech MTG
## Causal Inference tutorial from KDD2021

---

## KDD2021 Tutorial
- [KDD2021](https://kdd.org/kdd2021/) の面白かった [Tutorial](https://kdd.org/kdd2021/tutorials)
  - [Causal Inference and Machine Learning in Practice with EconML and CausalML](https://causal-machine-learning.github.io/kdd2021-tutorial/)
    - 機械学習を用いた因果推論(causal inference)とHands-on
    - 今回紹介する。
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
- outcome, treatment 両方に影響を与える  
  交絡因子(Confounders)の存在に注意する。
  - 事前の engagement が高ければ広告も見やすいし  
    新しいサービスも使う傾向が強い（広告はなくてもよいかも？）

![](./images/Causal_basic_graph.png)

---

## ランダム化比較実験 (RCT ; Randomized Controlled Trial)
- 処置への割り付けがランダムなら、交絡因子を無視できる
  - ランダム割り当てのA/Bテストがうまくいく理由

![](./images/Causal_randomized.png)

---

## ランダム実験ができない場合(1) : Unconfoundedness
- ランダム割り当てができなくても、交絡因子(Confounders)を  
  すべて観測できていれば、補正する方法がある
  - 傾向スコア(propensity score), IPW(inversed probability weight)
  - Meta Learner
  - Double Machine Learning

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
- 割り付けがランダムにならない。
  - 割り付け通りにユーザが思い通りの行動をとってくれない。
- 割り付けを考えずに収集されたデータを使って分析する
  - 観察研究(observational study)と呼ばれる

---

## 
このような場合に見たい効果
- ATE : Average Treatment Effect
- CATE : Average Treatment Effect

---

## Tutorialで説明されている例
- 会員登録
  - 登録をコントロールできない
- Web広告の出稿
  - 不特定多数の人に見せることになるので、
- ..

---

## Causal Inferenceの道具
- 確率モデル
- 傾向スコア法
- 機械学習手法
  - Meta Learner
  - Double Machine Learning
- 機械学習手法を実装したpython package
  - [CausalML](https://github.com/uber/causalml) (Uber)
    - Meta Learnerの手法を多数実装している。
  - [EconML](https://github.com/microsoft/EconML) (Microsoft)
    - Double Machine Learning の手法を実装している。

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
