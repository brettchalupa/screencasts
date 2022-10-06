# spec_helper vs rails_helper

A look into the difference between `require "spec_helper"` vs `require "rails_helper"` when using RSpec with Rails.

[📺 Watch the screencast](https://youtu.be/UkctRoFvSuc)

[📖 Read the blog post](https://code.brettchalupa.com/spec_helper-vs-rails_helper-explained)

## Performance

### spec_helper

Finished in 0.00182 seconds (files took 0.04228 seconds to load)

### rails_helper

Cold boot:  
Finished in 0.01671 seconds (files took 1.07 seconds to load)

w/ spring:  
Finished in 0.01058 seconds (files took 0.45144 seconds to load)

### result

The spec_helper loads the files for testing 25x faster!

even w/ spring, spec_helper is still 10x faster!
