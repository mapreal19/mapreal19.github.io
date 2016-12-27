---
layout: post
title: "How I built Encestado?"
---

# How I built Encestado?

<br>

In this post I’ll show the internals I used during the development of Encestado that I think is worth sharing.

{% include image.html file="encestado.png" %}

Encestado consisted in a sort of NBA manager. In the game you have a budget for choosing your NBA players for your lineup. Each week you receive points per each player depending on its performance in real NBA games. You could also compete with other users for achieving the top spot in the classification.

I no longer maintain Encestado because of lack of time, but it was a fun pet project that started in a Web Services class during my Master’s in Software Engineering.

Here I’ll share the tech stack I used for the development.

<br>

### Where is the Data?

<br>

The most important thing was the game logs. Where do I get the data for every player performance during a game? The original idea was to scrap the data from Nba.com using [Mechanize](https://github.com/sparklemotion/mechanize). I did a similar thing for retrieving players’ salaries from <http://www.espn.com/nba/salaries>:

<br>

{% highlight ruby %}
a = Mechanize.new { |agent|
      agent.user_agent_alias = 'Mac Safari'
    }

    page = a.get('http://espn.go.com/nba/salaries')

    page.search('//tr[@class="evenrow" or @class="oddrow"]').each do |player|
      # salary in form $321,234,323
      salary = player.search('td[4]').text.tr('$,', '')
      …
{% endhighlight %}

<br>

But for the game logs I was lucky to find within NBA.com the JSON service they use internally. If you dig through the inspector in Chrome you’ll find some of the resources I needed for the app. For instance if you’re curious on how Dirk Nowitzki is doing here you could find the related info:

<http://stats.nba.com/stats/playergamelog?Season=ALL&SeasonType=Regular+Season&PlayerID=1717>
￼
<br>

Screenshot:

{% include image.html file="dirk-stats.png" %}

So that was it! I had everything I needed! I created some cron jobs (take a look at [Whenever](https://github.com/javan/whenever)!) to run daily for updating the performance of every player. During one year I hadn’t had any problems (API limits, NBA realising I’m “stealing” their data, etc.) 

<br>

### Hosting/Backend

<br>

The rest of the app it was just a plain Rails app with some bits of JavaScript. I used [DigitalOcean](https://www.digitalocean.com/) for hosting and along with [Dokku](https://github.com/dokku/dokku) I had my Heroku-like infrastructure while paying just 5$ a month :)  

With docker I had some issues though. When running some cron tasks the containers from docker weren’t being removed, and that was filling my space to the point I had filled my 20GB. So I’ve come up with an additional cron job to clean up the containers that had exited. Here you could see my cron jobs using Whenever:  

<br>

{% highlight ruby %}
job_type :dokku_rails, "sudo -u dokku dokku run encestado.com rails r ':task'"
job_type :dokku_rake, "sudo -u dokku dokku run encestado.com rake :task"

every :thursday, :at => '11:00 am' do
  dokku_rake 'encestado:create_week'
end

every :day, :at => '10:00 am' do
  dokku_rake 'nba:game_logs'
end

# Clean up old (exited) containers
every :monday, :at => '9:00 am' do
  command "docker rm `docker ps -a | grep Exited | awk '{print $1 }'`"
end
{% endhighlight %}

<br>

I hope you enjoyed this and encourage you to build your own app. Happy Coding!  
