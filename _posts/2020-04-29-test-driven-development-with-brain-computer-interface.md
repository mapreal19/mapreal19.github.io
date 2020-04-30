---
layout: post
title: "Test Driven Development with Brain Computer Interface"
---

# Test Driven Development with Brain Computer Interface

<br>

A couple of definitions for those who aren't familiar with these terms:

**Test Driven Development**: (TDD) Is the practice in Software Engineering
of writing the tests before the code itself for a particular feature. This helps
simplifying the problem to solve while you build your solution incrementally.

**Brain Computer Interface**: (BCI) An interface that reads activity from your
brain in order to communicate with a computer without using devices like keyboard or
mouse.

[Neuralink](https://www.neuralink.com/) is the company most famous trying to achieve
a good BCI. The primary focus will be helping those patients with cervical injuries.
A known approach is using a bidirectional BCI, which will read activity from the
brain while also stimulating the sensory cortex, closing the loop and helping bypassing the nerve injury.

{% include image.html file="tdd-bci/bi-bci.png" text="Bidirectional circuit (https://www.coursera.org/learn/computational-neuroscience)" %}


But can we use BCI? I want it now 😩

There are some options out there that you can play around with. [OpenBCI](https://openbci.com/)
is a popular one. Other more commercials are [Mindwave](https://store.neurosky.com/pages/mindwave)
or [Emotiv](https://www.emotiv.com/).

If you feel adventurous you can build your own following instructions at [OpenEEG](http://openeeg.sourceforge.net/).
Be careful with the risks:

> However, if there is an isolation failure in the EEG unit due to an
accident, or faulty design, or faulty parts, or faulty construction, and
the EEG subject touches a live mains voltage in their environment, the
mains voltage will take the shortest route to earth, which is through the
subject's body. This electric shock passing through the head is likely
to have severe consequences.

{% include image.html file="tdd-bci/shock.jpg" text="Uhm ok..." %}

I ended up picking a device from Mindwave, since I didn't have much time for playing around it wouldn't
make sense investing in a more expensive device.

For a quick demonstration what I wanted to achieve is to execute tests each time I had 2 blinks. Technically
I'm not using the electrical activity from the brain, but from the muscles in the eye in charge of performing a blink.
But the idea is the same. I'm giving an order from my brain to execute a command in my computer, which is faster
than using a shortcut with the keyboard or using the mouse.

{% include image.html file="tdd-bci/no-hands.jpg" %}

After researching a bit on how to connect to the device I've found is not that complicated using JavaScript.
Once you have the *ThinkGearConnector* running with the *logging* option enabled
you will be able to interact with the device:

{% highlight javascript %}
import net from 'net';

const MINDWAVE_PORT = 13854;

const client = net.createConnection({ port: MINDWAVE_PORT }, () => {...});
{% endhighlight %}

<br>

After you should provide some configuration options, like app name, format etc.

{% highlight javascript %}
const data = {
  appName: "Brainwave BlinkTDD",
  appKey: "9f54141b4b4c567c558d3a76cb8d715cbde03096",
};
client.write(JSON.stringify(data));

const config = {
  enableRawOutput: true,
  format: "Json"
};
client.write(JSON.stringify(config));
{% endhighlight %}

<br>

Then you should be ready for listening the data from the Mindwave device. Normally
you will get values for your meditation/attention current state as well as values
for each type of your brain waves:

{% include image.html file="tdd-bci/data.png" %}

You can get those with the following code:

{% highlight javascript %}
client.on('data', (data) => {
  const parsedJson = JSON.parse(data.toString());
  console.log("Mindwave data:");
  console.log(JSON.stringify(parsedJson, null, 2));
});
{% endhighlight %}

<br>

Now for our demo project, I want to detect 2 blinks in a row. Luckily, the device
tell us when a blink is detected with its detected blink strength. This is good for tuning out
accidental blinks. You will receive a property in the JSON called `blinkStrength` with its corresponding
value.

So with the following code we can detect when 2 blinks are detected and execute a command of our choice.
In this case we will run tests with Jest.

{% highlight javascript %}
let previousMindwaveData = {};

client.on('data', (data) => {
  const parsedJson = JSON.parse(data.toString());

  const hasTwoBlinks = parsedJson.hasOwnProperty('blinkStrength') &&
     previousMindwaveData.hasOwnProperty('blinkStrength');

  if (hasTwoBlinks) {
    console.log("2 blinks detected! Let's run some tests =>");

    exec("jest", (error, stdout, stderr) => {
      if (error) {
        console.log(`error: ${error.message}`);
        return;
      }
      if (stderr) {
        console.log(`stderr: ${stderr}`);
        return;
      }
      console.log(`stdout: ${stdout}`);
    });
  }

  previousMindwaveData = parsedJson;
});
{% endhighlight %}

<br>

I recorded a video so you can see it in action:

<br>

<center>
  <iframe
    width="560"
    height="315"
    src="https://www.youtube.com/embed/LyIu-4hCSo8?rel=0"
    frameborder="0"
    allowfullscreen>
  </iframe>
</center>

<br>

Obviously, I won't use this while I'm coding, the device is not that comfortable,
but will see in the future :)

If you want to see the code you can find it in [Github](https://github.com/mapreal19/mindwave-blink).
