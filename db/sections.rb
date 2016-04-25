# course_id
# crn
# days
# start
# end
# professor

def course_id
  (Random.rand * 36).floor
end

def crn
  (Random.rand * 80000).floor + 10000
end

def days
  d = ['mwf', 'mwf', 'mwf', 'tr', 'tr', 'mw']
  d[(Random.rand * d.length).floor]
end

def start
  3600 * (8 + (Random.rand * 9).floor) + (60 * 5)
end

def end_(start, days)
  if days.length == 2
    start + 60 * 80
  else
    start + 60 * 50
  end
end

def professor
  p = ['Robert Waters', 'Jay Summet', 'Kishore Ramachandran', 'Bill Leahy', 'Russ Clark', 'Monica Sweat']
  p[(Random.rand * p.length).floor]
end

120.times do |id|
  d = days
  s = start
  e = end_ s, d

  puts "safe_create Section.new(id: #{id}, course_id: #{course_id}, crn: #{crn}, days: '#{d}', start: #{s}, end: #{e}, professor: '#{professor}')"
end
