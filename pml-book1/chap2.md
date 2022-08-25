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
    - **Probability densitry function** (pdf) : $p(x) := \frac{d}{dx}P(x)$

---

### 2.2.2.3 Quantile / Quartiles

- **Quantile** : inverse cdf / percent point function (ppf)
  - q's quantile $:= P^{-1}(q)$
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
- product rule : $$p(x,y) = p(x)p(y|x)$$
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
  $$\mathbb{V}[\prod_{i=1}^{n} X_i]
    = \prod_i (\sigma_i^2 + \mu_i^2) - \prod_i \mu_i^2$$

---

### 2.2.5.4 Conditional moments

- **law of iterated expectations** / **law of total expectation**
  $$\mathbb{E}[X] = \mathbb{E}_Y [\mathbb{E}[X|Y]]$$
- derivation
$$\begin{aligned}
\mathbb{E}_Y [\mathbb{E}[X|Y]]
 &= \mathbb{E}_Y \left[\sum_x x  p(X=x | Y) \right] \\
 &= \sum_y \left[ \sum_x x  p(X=x | Y=y) \right] p(Y=y) \\
 &= \sum_{x,y} x p(X=x , Y=y) = \mathbb{E}[X]
\end{aligned}
$$
- Example : Lightbulb
  - Factory 1 supplies 60% bulbs, lifetime $X = 5000$ (hr)
  - Factory 2 supplies 40% bulbs, lifetime $X = 4000$ (hr)

---

### 2.2.6 Limitation of Summary Statistics

---

### 2.3 Bayes' rule

- Bayes' rule
  - For unknown (**hidden**) quantity $H$
  - Given some observed data $Y=y$
$$p(H=h|Y=y)
 = \frac{p(H=h) p(Y=y|H=h)}{p(Y=y)}
$$
- Details
  - $p(H=h)$ ... **Prior Distribution**
  - $p(Y=y|H=h)$ ... **Likelihood**
  - $p(H=h|Y=y)$ ... **Posterior Distribution**
- **Posterior** $\propto$ **Prior** $\times$ **Likelihood** 

---

### Example 1 : Testing for COVID-19

---

### Example 2 : The Monty Hall problem

---

### 2.4 Bernoulli / Binomial distribution

- **Bernoulli** : $Y \sim \textrm{Ber}(\theta)$
  - $Y \in \{0, 1\}$  (ex) coin toss (1=head / 0=tail)
  - $0 \le \theta \le 1$ (ex) probability of head
$$\begin{aligned}
\textrm{Ber} (y|\theta)
&=
  \begin{cases}
    1 - \theta & \textrm{if} &  y = 0 \\
    \theta & \textrm{if} &  y = 1
  \end{cases} \\
&= \theta^y (1 - \theta)^{1-y}
\end{aligned}
$$      
- **Binomial** : $Y \sim \textrm{Bin}(s|N, \theta)$
  - $s \in \{0, 1, ..., N\}$ (ex) num of heads in $N$-times coin toss