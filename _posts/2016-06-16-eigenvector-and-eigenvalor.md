---
layout: post_with_math
title: "EigenVector &amp; EigenValor"
---

# EigenVector & EigenValor

<br>

Según Wikipedia, los **eigenvectores** son los vectores no nulos que, cuando son
transformados por el operador, dan lugar a un múltiplo escalar de sí mismos,
con lo que no cambian su dirección. Este escalar **λ** recibe el nombre de **eigenvalor**.

<br>

#### Definición

Dada una matriz **M** de dimensión **n x n**.

Un escalar **λ** es un eigenvalor de **M** si existe un vector no nulo $$\overline{x}$$ de forma
que $$A\overline{x} = λ\overline{x}$$. Este vector $$\overline{x}$$ es llamado
un eigenvector de **A** con respecto a **λ**.

Además, si **λ** es eigenvalor de **A**, y $$\overline{x}$$ es un eigenvector con
respecto a **λ**, cualquier múltiplo distinto de $$0$$ de $$\overline{x}$$ será un
eigenvector.

<br>

#### Cálculo
En el video que pongo como referencia se explica bien los pasos para calcular los eigenvectores
y eigenvalores de una matriz.

Son los siguientes:

Dada una matriz **A** de dimensión **n x n**.

1 - Multiplica a la matriz identidad de dimensión **n x n** el scalar **λ**

2 - A la matriz **A** réstale la matriz identidad anterior

3 - Encuentra el determinante de la matriz de la diferencia anterior

4 - Encuentra los valores de **λ** que satisfacen la ecuación:  $$det(A - λI) = \overline{0}$$

5 - Encuentra el vector correspondiente para cada **λ**

<br>

Pongamos un ejemplo de cómo realizar esto:

<br>

$$
        A =
        \begin{pmatrix}
        3 & 2 \\
        3 & -2 \\
        \end{pmatrix}
$$

$$\fbox{1}$$

$$
        \lambda I =
        \lambda
        \begin{pmatrix}
        1 & 0 \\
        0 & 1 \\
        \end{pmatrix} =
        \begin{pmatrix}
        \lambda & 0 \\
        0 & \lambda \\
        \end{pmatrix}
$$

$$\fbox{2}$$

$$
        \begin{pmatrix}
        3 & 2 \\
        3 & -2 \\
        \end{pmatrix} -
        \begin{pmatrix}
        \lambda & 0 \\
        0 & \lambda \\
        \end{pmatrix} =
        \begin{pmatrix}
        3 - \lambda & 2 \\
        3 & -2 -\lambda \\
        \end{pmatrix}

$$

$$\fbox{3}$$

$$
        \det
        \begin{pmatrix}
        3 - \lambda & 2 \\
        3 & -2 -\lambda \\
        \end{pmatrix} =
        (3 - \lambda)(-2 -\lambda) - 6 =
        \lambda^2 - \lambda - 12
$$

$$\fbox{4}$$


$$\lambda^2 - \lambda - 12 = 0$$

$$
        \lambda = \frac{1 \pm \sqrt{4*12 +1}}{2} \to
        \begin{cases}
        \lambda = 4 \\
        \lambda = -3
        \end{cases}
$$

$$\text{Ya hemos obtenido nuestros eigenvalores. Pasemos ahora a calcular un eigenvector:}$$

$$\fbox{5}$$

$$
        \begin{pmatrix}
        -1 & 2 \\
        3 & -6 \\
        \end{pmatrix}
        \begin{pmatrix}
        x_1 \\
        x_2 \\
        \end{pmatrix} = \overline{0}
$$

$$3R_1 + R_2 \to R_2$$

$$
  \left(
    \begin{array}{cc|c}
      -1 & 2 & 0 \\
      0 & 0 & 0
    \end{array}
  \right) \to
  \ -x_1 + 2x_2 = 0
$$

$$x_1 = 2x_2$$

$$\text{Con la anterior fórmula ya podrías obtener los eigenvectores. E.g.}
\to
\begin{cases}
x_1 = 2 \\
x_2 = 1
\end{cases}

$$

<br>

Veamos ahora como podemos hacer esto mismo con un lenjuage de programación.

<br>

#### Ruby al rescate

Utilizo Ruby porque es mi lenguaje preferido, pero estoy seguro de que tenemos alternativas
en otros lenguajes.

Dada la matriz anterior, podremos sacar los eigenvectores y eigenvalores de la siguiente forma:

{% highlight ruby %}
require 'matrix'

matrix = Matrix[[3, 2], [3, -2]]
eigen_system = matrix.eigen

eigenvalues = eigen_system.eigenvalues # => [4.0, -3.0]
eigenvectors = eigen_system.eigenvectors
{% endhighlight %}

<br>

#### Referencias

- https://es.wikipedia.org/wiki/Vector_propio_y_valor_propio
- [Introduction to Eigenvalues and Eigenvectors](https://www.youtube.com/watch?v=G4N8vJpf7hM)
