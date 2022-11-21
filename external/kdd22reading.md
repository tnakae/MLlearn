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

- [Non-stationary A/B Tests](https://dl.acm.org/doi/10.1145/3534678.3539325)
  - Yuhang Wu+ (University of California, Berkeley と Amazon の混成チーム)
  - KDD 2022
- 要旨
  - A/Bテストの対象となるmetricsが、定常性を満たさない場合に、
    A/Bテストの推定値の分散が大きくなるケースがある。
  - 非定常であるmetricsに対して、A/Bテストの推定値の分散を
    低減させる方法を提案

---

<!--_class: normal-->

## 前提
- 時系列が日内変動や、曜日の影響を受ける場合

![center width=400px](./images/NonStationary_Example.png)

---

<!--_class: normal-->

## 結論

---

<!--_class: normal-->

## 前提 (通常のA/B)

---

<!--_class: normal-->

## 非定常性の前提

---

<!--_class: normal-->

## 定理

---

<!--_class: normal-->

## 分散評価

---

<!--_class: normal-->

## 具体例

---

<!--_class: normal-->

## まとめ
