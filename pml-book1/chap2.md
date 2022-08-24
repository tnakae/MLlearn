# pml-book1
## 2 : Probability: Univariate Models

---

### 2.2 Random Variables

- Basic
  - $X \in \mathcal{X}$ ... **random variable** (rv)
  - $\mathcal{X}$ ... **sample space** / **state space**
- Discrete / Continuous
  - $X$ is **discrete rv** $\Leftrightarrow$ $\mathcal{X}$ is finite/countably infinite
    - **Probability mass fuction** (pmf) : $p(x) := \mathrm{Pr}(X=x)$
  - $X$ is **continuoius rv** $\Leftrightarrow$ $\mathcal{X} \in \mathbb{R}$
    - **Cumulative distribution fuction** (cmf) : $P(x) := \mathrm{Pr}(X \le x)$
    - **Probability densitry function** (pdf) : $p(x) := \frac{d}{dx}P(x) $

---

### 2.2.2.3 Quantile / Quartiles

- **Quantile** : inverse cdf / percent point function (ppf)
  - q's quantile $ := P^{-1}(q)$
- **Quartiles**
  - $P^{-1}(0.25)$ and $P^{-1}(0.75)$ are the lower / upper **quartiles**
  - 日本語では、四分位点(しぶんいてん)という。
- Example
  - $\Phi$ ... cdf of Gaussian distribution $\mathcal{N}(0,1)$
    - $(\Phi^{-1}(0.025), \Phi^{-1}(0.975))=(-1.96, 1.96)$ \
      is 95% interval.

---

### 2.2.3 joint distribution / 2.2.4 independence etc

- **Joint distribution**
  $$p(x,y) := p(X=x, Y=y)$$
- **Conditional distribution**
  $$p(Y=y|X=x) := \frac{p(X=x, Y=y)}{p(X=x)}$$
- product rule : $$ p(x,y) = p(x)p(y|x) $$
- **(unconditionally) independence** / marginally independence
  $$X \perp Y \Longleftrightarrow p(X,Y)=p(X)p(Y)$$
- **conditionally independence** (CI)
  $$X \perp Y | Z \Longleftrightarrow p(X,Y|Z)=p(X|Z)p(Y|Z)$$

---

### 2.2.5 Moments of a distribution

- **mean** / **expected value**
  - for discrete rv : $\displaystyle \mathbb{E}[X] := \int_{\mathcal{X}} x p(x) dx$
  - for continuous rv : $\displaystyle \mathbb{E}[X] := \sum_{x \in \mathcal{X}} x p(x) dx$
- **variance** (often denoted by $\sigma^2$)
  - $\mathbb{V}[X] := \mathbb{E}[(X - \mu)^2]$
  - **standard deviation** : $\mathrm{std}[X] := \sqrt{\mathbb{V}[X]} = \sigma$
- The variance of product of $n$ independent rv:
  $$\mathbb{V}[\prod_{i=1}^{n} X_i] = $$