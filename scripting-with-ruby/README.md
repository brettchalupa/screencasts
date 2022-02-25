# Scripting with Ruby

Code alongside me as I write a script in Ruby to organize MP3s into folders
based on their metadata.

## Why Ruby for Scripting

Ruby, lately, seems used mostly for web app development with Rails, which is
fantastic. But Ruby can be used for so much more, and I think one of the cases
where it shines is general purpose scripting, especially with the file system.

Whether you're mass converting a bunch of files or interacting with Git, Ruby's
got a great standard library and plenty of third-party dependencies to make it
a joy.

In this particular screencast, I replicate a recent scenario where I downloaded
a zip with thousands of MP3 files in it without any folder structure. It was
impossible to know what I was working with and which files belonged to a given
artist or album. So I wrote a Ruby script that looped through each file, read
the metadata, and easily organized them all into folders based on artist and
album!

See the `_organize.rb` script for the resulting code.

## References

- [FileUtils](https://ruby-doc.org/stdlib-3.1.0/libdoc/fileutils/rdoc/FileUtils.html)
- [File](https://ruby-doc.org/core-3.1.0/File.html)
- [Dir](https://ruby-doc.org/core-3.1.0/Dir.html)
- [id3tag gem](https://rubygems.org/gems/id3tag) -- view MP3 metadata from a Ruby file

## Versions

- Ruby 3.1.0
- [id3tag 0.14.2](https://rubygems.org/gems/id3tag/versions/0.14.2)

