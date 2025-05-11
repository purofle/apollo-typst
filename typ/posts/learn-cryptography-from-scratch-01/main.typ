#import "@preview/shiroa:0.1.0": *
#import "@preview/typst-apollo:0.1.0": pages
#import pages: *
#import "@preview/shiroa:0.1.0": get-page-width, target, is-web-target, is-pdf-target, plain-text

#import "@preview/unequivocal-ams:0.1.0": theorem, proof

#show strong: content => {
  show regex("\p{Hani}"): it => box(place(text("·", size: 0.8em), dx: 0.1em, dy: 0.75em) + it)
  content.body
}

#show: project.with(
  title: "从零学习密码学-有限域与椭圆曲线",
  authors: (
    (
      name: "purofle",
      email: "purofle@gmail.com",
    ),
  ),
)

#set par(justify: true)

// = 从零学习密码学-有限域与椭圆曲线
== 有限域的定义与运算规则
在密码学中，只研究有有限个元素的域，即有限域.

有限域的定义：
- 域中只包含有限个元素，元素的个数叫做域的阶$q$.
- 一个阶为$q$的有限域，只有当$q$是一个素数幂(其中$q=p^k$，$p$是素数，$k in NN^*$)时，这个域才存在.其中，$p$叫做域的特征(characteristic).#super[@dummit_foote_2003]

有限域由素数$p$定义而成，包含从$0$到$p-1$的整数：
$ FF_p = {0,1,2...,p-1} $

当然，有限域的另一种表示形式$"GF"(p)$可能更常见。

在有限域中，加法跟乘法都是通过$mod p$来计算的.选择一个较小的$p = 10$来举个例子：
$ 3+9=12 mod 10 = 2 $
所以 $ 3+9 equiv 2 mod 10 $
乘法与加法相同：
$ 3 times 9=27 mod 10 = 7 $
所以 $ 3 times 9 equiv 7 mod 10 $

== 逆元计算
定义：
如果一个线性同余方程$"ax" equiv 1 mod b$，则$x$称为$a mod b$的逆元#super[@number_theory_inverse]，记作$a^(-1)$.

那么逆元运算有什么用呢？可以使用逆元计算椭圆曲线域上的点加法。在开始之前，我们先学习椭圆曲线。

== 椭圆曲线
椭圆曲线是一个这样的二元三次方程：
$ y^2+"axy"+"by"=x^3+"cx"^2+"dx"+e $
其中 $a,b,c,d,e$是实数，$x,y$是变量.

在密码学中，最常用的椭圆曲线方程是：
$ y^2 = x^3+"ax"+b $
同时：
$ a, c in "GF"(P), Delta = 4a^3+27b^2 != 0 $

首先，我们有椭圆曲线有限域$E_p(a,b)$，设$P,Q$是椭圆上的两个点，于是我们有：
$ {(x,y) mid(|) 0<=x<=p, 0<=y<=p, x,y in NN^* } $
而且
$ P + 0 = P $

椭圆曲线有限域上有这样的加法法则：
- 如果$P=(x,y)$，那么$(x,y)+(x, -y)=O，$即$(x,-y)$是$P$的加法逆元，又叫做$-P$.

设$P=(x_1, y_1), Q=(x_2, y_2), P+Q=(x_3, y_3)$

然后，我们需要计算斜率$lambda$，公式如下：
$ lambda := cases(
  (y_2-y_1)/(x_2-x_1)"," P != Q,
  (3x_1^2+a)/(2y_1)"," P = Q,
) $

*注意：这里的除法是有限域的除法，也就是$"GF"(P)$下的乘法逆元.*

在计算斜率$lambda$时，我们就用到了刚才所提到的逆元运算.在有限域$"GF"(p)$中，除法是通过乘以$p$的逆元来实现的.

这时，我们可以直接计算出$x_3$跟$y_3$：
$ x_3 equiv lambda^2 - x_1 - x_2(mod p) $
$ y_3 equiv lambda(x_1-x_3) - y_1(mod p) $

- 思考1：为什么不能直接将两个坐标相加？

椭圆曲线有限域内的加法是定义在椭圆曲线上的，在这个有限域内，两个点相加后的坐标仍然在椭圆曲线上.

- 思考2：为什么可以通过斜率来计算坐标？

首先我们需要有一个基本思想，一条直线与一条上述定义内的椭圆曲线最多有三个交点.（这里的交点考虑到了重合跟无穷远点$O$)

接着通过几何的方式来思考问题。取椭圆曲线上两个不同的点($P(x_p, y_p), Q(x_q, y_q))$，画一条通过这两个点的直线，跟椭圆曲线交于第三个点$R$，那么$P+Q=R$，$R$的坐标为$R(x_r, y_r)$.

已知斜率$lambda$，设直线方程为$y=lambda(x-x_p)+y_p$，将直线方程直接代入椭圆曲线方程，得到：
$ lambda(x-x_p)+y_p = x^3+"ax"+b $
接着，代入一元三次方程的韦达定理（这里省略，不然写太多了）可以算出：
$ x_p+x_q+x_r=lambda^2 $
这时可以直接推出第三个交点坐标：
$ x_r = lambda^2 - x_r - x_q $
将$x_r$直接代入直接方程，即可得到$y_r$.

- 思考3：为什么在$P=Q$时，坐标不等于他们本身？
根据椭圆曲线有限域的定义，每个点都必须在椭圆曲线上。因此$P+P=2P$这种情况下只有在$P$为无穷远点$O$时才成立.

- 思考4：为什么在$P=Q$时$lambda$的计算公式是这样的？
这里其实推荐直接看这个视频：#link("https://www.bilibili.com/video/av10686474", "微积分的本质 - 06 - 隐函数求导是怎么回事？- 3Blue1Brown")

如果你硬要看我算的话，过程在这里：

当$P=Q$时，我们求的$lambda$其实是与椭圆曲线相切的直线的斜率，于是我们可以先写出椭圆曲线方程：
$ y^2=x^3+"ax"+b $
对左侧求导得：
$ d/"dx"y^2=2y dot "dy"/"dx" $
对右侧求导得：
$ 3x^2+a $
相加得：
$ 2y"dy"/"dx"=3x^2+a $
最后解出$"dy"/"dx"$即可：
$ "dy"/"dx"=(3x^2+a)/(2y) $

#bibliography("refs.bib")