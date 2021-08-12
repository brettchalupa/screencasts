greetings = ["howdy!", "hi", "hello", "yooooo", "wasup!"]

greetings.each do |greeting|
  puts greeting
end

formatted_greetings = greetings.map do |greeting|
  greeting[0].upcase + greeting[1..-1]
end

formatted_greetings.each do |greeting|
  puts greeting
end

greetings.each do |greeting|
  puts greeting
end
