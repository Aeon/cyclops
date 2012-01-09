Prerequisites
-------------

 - ffmpeg
 - imagemagick
 - ruby
 - [chronic_duration](https://github.com/hpoydar/chronic_duration) gem

Instructions
------------

Step 1: Make cyclops.rb executable

Step 2: Run `./cyclops.rb movie.avi`

Step 3: Examine resulting `movie.jpg`

Step 4: Profit!

Warning
-------

Cyclops is stupid and does no error checking. Invalid movie files, non-writeable directories, etc, will lead to breakage. No warranty against it formatting your dog or eating your hard drive is expressed or implied.
