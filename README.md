# iOSCodingChallenge

Here's a coding challenge we give to developers looking for mobile jobs.  Feel free to ask any questions to fill in the blanks.

Starting with the skeleton app provided in this repo, create an app that does the following:

1. Makes an HTTP call to a webservice at https://public.touchofmodern.com/ioschallenge.json
2. In the body of the request, send a JSON payload with today's date in it, like this: "{requestDate: 'yyyy-mm-dd'}"
3. If the request is correctly formatted, you'll get back a payload like this, describing a list of products (if it's not correctly formatted, you'll get an error response):
{
  products: [
   {name: 'Product A', image: 'https://photos.touchofmodern.com/blah/blah.png', price: 12.33, description: "blah blah"},
 {name: 'Product B', image: 'https://photos.touchofmodern.com/blah/blah.png', price: 66.33, description: "blah blah"},
 {name: 'Product C', image: 'https://photos.touchofmodern.com/blah/blah.png', price: 12.99, description: "blah blah"},
 {name: 'Product D', image: 'https://photos.touchofmodern.com/blah/blah.png', price: 14.33, description: "blah blah"}
  ]
}
4. Display the products nicely in a scrollable list including their name, their image, their description, and their price.  Use our existing app for an idea of our asthetic.

Please don't use any high-level libraries (pods) for this work.  We're interested in your coding style, and not your ability to hammer together external libraries.

Bonus points for:

1. Sorting the list of products by price
2. Allowing the user to swipe left and remove a product from the list, never to see it appear again


We expect this exercise to take no more than a few hours.  If it's taking longer than that, then please be in touch becuase you might be doing more than is required.


## How to submit your results

Please follow these directions precisely because they affect our ability to evaluate your results.

1. Fork this repo
2. Create a new branch in your repo with your name (ie. tim-cull)
3. Do your coding challenge and push to your forked repo
4. Email a link to your repo to tim.cull@touchofmodern.com and the recruiter you're working with (i.e. Sally or Tarveen) to let us know you're ready.

## What we are looking for

We are looking for several things in this challenge.  First, of course, we're looking for your answer to be technically correct.  Beyond that, we're also looking for:

1. Is your code easy to read and understand?
2. Are you following the usual conventions for iOS development?
3. Are you handling unreliable network connections nicely?
4. Are you handling different sized devices nicely?
4. Did you follow these directions?

Basically, write the code as if you were going to release it to a real website with real users who spend real money.  Because that's what we do.

When we get your response, here's exactly what we're going to do:

1. Open it up in XCode
2. Run it in the simulator in a variety of devices (iPhone 6, iPhone 4s, iPad, etc)
3. Look at the code itself to see its correctness, readability, and general elegance

That's it.  There aren't any hidden gotchas or trick questions.  That's really what we're going to do.

If you have any questions, please don't hesitate to contact me at tim.cull@touchofmodern.com

