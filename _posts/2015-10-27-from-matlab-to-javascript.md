---
layout: post
title: "From Matlab to JavaScript"
---

# From Matlab to JavaScript

Recently I've been reading an introductory book about *Computational
Neuroscience* ([Tutorial on Nueral Systems Modeling](http://www.amazon.com/Tutorial-Neural-Systems-Modeling-Anastasio/dp/0878933395/)).
You may wonder if this is complicated. Well, you're right, it is complicated
¯\\_(ツ)_/¯.

The scripts taken from this book are written in *Matlab*. Since I'm a
huge believer of Open Source-ness I thought it could be nice to port this into
*JavaScript*.

Let's have a look at one of the first examples. The following script is quite
simple. It just simulates the response of the brain to a continuous stimulus
(i.e. [Habituation](https://en.wikipedia.org/wiki/Habituation)).

{% gist mapreal19/8aea9eee8f8e69577665 %}

So let's port this into JavaScript! Some of the latest trends on web
technologies are being used here: [ECMAScript 2015](http://www.ecma-international.org/ecma-262/6.0/),
[Webpack](https://webpack.github.io/) & [d3.js](http://d3js.org/)

{% gist mapreal19/ca0ad4bdc043ed7e1c0e %}

You could see the output of both scripts: *Matlab* (first) & *JavaScript* (last):

<span class="row">
  ![Output Octave]({{ site.url }}/img/blog/output-octave.png){: .img-responsive .col-md-6 }
  ![Output JavaScript]({{ site.url }}/img/blog/output-js.png){: .img-responsive .col-md-6 }
</span>

In conclusion, as a learning exercise we've taken some *Matlab* code and ported it
into *JavaScript*. *[Octave](https://www.gnu.org/software/octave/)* is a nice alternative for this.

**OpenSource FTW!**
