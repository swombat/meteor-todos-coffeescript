# Meteor - Todos, coffeescript version

This is my conversion of the Todos example to coffeescript. I also tidied up the file structure (according to what I felt makes sense), and tweaked some of the functionality.

## Installation notes

Assuming the good folks at Meteor haven't included that in the main repo yet, you also need to pull a [specific commit](https://github.com/JasonGiedymin/meteor/commit/6452d98bf3678ab56fe840ae65f5a6d45b18e353) from [Jason Giedymin's fork](https://github.com/JasonGiedymin/meteor). Instructions to pull a given commit from a fork are [here](http://stackoverflow.com/questions/6022302/pull-requests-from-other-forks-into-my-fork).

In short, after making your own fork:

    > git remote add jasongiedymin git://github.com/JasonGiedymin/meteor.git
    > git fetch jasongiedymin
    > git cherry-pick 6452d98bf3678ab56fe840ae65f5a6d45b18e353

Then install:

    > ./install.sh

If you don't do this, CoffeeScript will, by default, wrap every file in a (function() { }).call(); which will make global variables (like the MiniMongo LocalCollections) invisible outside of the file they're defined in.

