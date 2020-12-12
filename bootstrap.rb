#! /usr/bin/env ruby

days = (1..25).to_a
YEAR = ARGV[0]

raise ArgumentError, 'No year provided' unless YEAR

days.each do |day|
day = day.to_s.rjust(2,'0')
  `mkdir -p #{YEAR}/day#{day}`
  `cp template.rb #{YEAR}/day#{day}/1.rb`
  `sed -i 's/YEAR/#{YEAR}/' #{YEAR}/day#{day}/1.rb`
  `sed -i 's/DAY/#{day}/' #{YEAR}/day#{day}/1.rb`
  `cp #{YEAR}/day#{day}/1.rb #{YEAR}/day#{day}/2.rb`
  `touch #{YEAR}/day#{day}/input.txt`
end
`chmod +x #{YEAR}/**/*.rb`
