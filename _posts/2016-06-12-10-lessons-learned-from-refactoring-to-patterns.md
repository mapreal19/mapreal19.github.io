---
layout: post
title: "10 Lessons Learned from Refactoring To Patterns"
---

# 10 Lessons Learned from Refactoring To Patterns

<br>

Recently I took an online course about
[**Refactoring to Patterns**](https://geekshubsacademy.com/cursos/refactoring-a-patrones).
Here are some keys lessons learned in that course:

<br>

1 - **Avoid Comments**

Use tests or README instead. If you're involved in a
project where comments are present, use your own code to show how you absorb those
comments with code/tests.

{% include image.html file="no-comments.png" %}


2 - **Options is an Object**

If you're passing options as a parameter, sometimes it's a good idea to encapsulate
those options into its own object.

{% include image.html file="goku.jpg" %}

3 - **Switch off Switches**

Just don't use them.

{% include image.html file="switch-off.jpg" %}

4 - **Null is never a message**

Don't use Null to send a message in your method.

{% include image.html file="nil-msg.jpg" %}

5 - **Encapsulate Collections**

Collections are like Pokemons, they always evolve...

{% include image.html file="pikachu.jpg" %}

6 - **Thesaurus is your Friend**

We know naming is hard... That's why [Thesaurus](http://www.thesaurus.com/)
will help you out to find better names either with synonyms or antonyms.

{% include image.html file="thesaurus.jpg" %}

7 - **Services don't return 'Alien Objects'**

A service must be distributed. It only can use primitives or DTOs.

{% include image.html file="alien-service.png" %}

8 - **Services don't raise exceptions**

Instead they should return an error message.

{% include image.html file="service-exception.jpg" %}

9 - **Null Object**

Always try to use the [Null Object pattern](https://en.wikipedia.org/wiki/Null_Object_pattern).

{% include image.html file="no-money.jpeg" %}

10 - **For needs a Break**

Don't `return` inside a `for` loop to halt its execution. Use `break` instead.

{% include image.html file="prison-break.jpg" %}
