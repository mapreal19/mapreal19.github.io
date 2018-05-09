---
layout: post
title: "Solving the Peg Solitaire with Backtracking"
---

# Solving the Peg Solitaire with Backtracking

When I was a kid I struggled with Peg Solitaire. I found it almost impossible
to find a solution and my best score was having 2 pegs left. You win the game if
you are left with only 1 peg left.

{% include image.html
  file="peg-solitaire/peg-solitaire.jpg"
  text="Classic Peg Solitaire board. https://en.wikipedia.org/wiki/Peg_solitaire"
%}

I gave up on the problem. But then, some years later I started at the University with
my first adventures on programming with C++. There was an "Aha!" moment when I learnt
about some algorithmic technique called Backtracking. Basically, Backtracking allows
you to explore all possible solutions for a given problem. If it goes through some path
where it can't a find solution it "goes back" and tries a new path.

{% include image.html
  file="peg-solitaire/backtracking.png"
  text="Backtracking. Credit: https://www.w3.org/2011/Talks/01-14-steven-phenotype/"
%}

So the only missing thing was how to model the Peg Solitaire board and its movements. Easy peasy.
We could just model the board as a 7x7 matrix. I then assigned some numeric codes
depending on if the peg is present (1), not present (0) and if the position is outside of
the board (-1).

{% include image.html
  file="peg-solitaire/peg-matrix.png"
  text="Board as Matrix"
%}

Regarding movements for a given position within the matrix we should check all possible
movements if any. For instance, for the position within the matrix [1, 3] a valid movement
would be moving the peg to the right. This would be the resulting matrix:

{% include image.html
  file="peg-solitaire/peg-matrix-2.png"
%}

You could check the original code in [C++](https://github.com/mapreal19/peg-solitaire/blob/master/bolas.cc)
or a refactored solution in [Ruby](https://github.com/mapreal19/peg-solitaire/blob/master/peg_solitaire.rb)
(the refactor is not complete, so feel free to improve the solution and submit a pull request).

Here a relevant bit from the C++ code:

{% highlight c++ %}
if((j + 2) < 7 && M[i][j + 1] == 1 && M[i][j + 2] == 0) { // Can move peg to the right
  M[i][j] = 0;
  M[i][j + 1] = 0;
  M[i][j + 2] = 1; // peg moves to this position "eating" the adjacent

  // Solution update
  solution[pegs_count - 1].row = i;
  solution[pegs_count - 1].col = j;
  movements[pegs_count - 1] = "right";
  pegs_count--;

  // Backtracking call. It goes to a child node
  backtracking(M, pegs_count, solution, movements);

  // It didn't find a solution
  // Let's undo the movement and will try with another child
  M[i][j] = 1;
  M[i][j + 1] = 1;
  M[i][j + 2] = 0;
  pegs_count++;
}
{% endhighlight %}

<br>

Here you could check the solution found by the above scripts:

<iframe width="100%" height="400" src="https://www.youtube.com/embed/Qkjyvem42Pg?rel=0&amp;ecver=1" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>

<br>

So here you have a clear example of [Transfer of Learning](https://en.wikipedia.org/wiki/Transfer_of_learning).
Hopefully this will inspire you to solve similar problems.

Happy coding! 💻
