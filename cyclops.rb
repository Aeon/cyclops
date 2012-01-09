#!/usr/bin/env ruby
require 'rubygems'
require 'chronic_duration'

frame_count = 18

movie = ARGV[0]
name = File.basename(movie, '.*')

`ffmpeg -i "#{movie}" 2>./tmp_movie_info.txt`
duration = `grep "Duration" ./tmp_movie_info.txt | cut -d ' ' -f 4 | sed s/,//`
aspect = `grep 'Stream .* Video' ./tmp_movie_info.txt | cut -d ',' -f 3`.match(/(\d+)x(\d+)/)

thumb_height = ((Float(aspect[2]) / Float(aspect[1])) * 320).round

puts "Processing #{name}"
puts "Duration: #{duration}"

seconds = ChronicDuration.parse(duration)

skip_seconds = seconds / (frame_count+1)

(1..frame_count).each do |i|
  offset = (i * skip_seconds).round
  puts "Thumb %d at %s" % [i, ChronicDuration.output(offset, :format => :chrono)]
  thumb_name = "tmp_thumb_%02d.jpg" % i
  `ffmpeg -ss #{offset} -i "#{movie}" -vframes 1 -s 320x#{thumb_height} #{thumb_name} 2>/dev/null`
end

puts "Creating montage"
`montage -background '#FFFFFF' -geometry '+4+4' -tile 3x6 tmp_thumb* "#{name}.jpg"`

`rm ./tmp_movie_info.txt`
`rm ./tmp_thumb_*`
puts "Done!"
