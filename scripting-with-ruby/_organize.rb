# Organize a directory of MP3s into subdirectories based on album, artist,
# track number, and track title.
#
# Creates a backup in `_backup` in case the script really makes a mess.
#
# Be sure it install id3tag first: gem install id3tag
#
# Run with: ruby _organize.rb

require "fileutils"
require "id3tag"

BACKUP_DIR = "_backup"
LIB_DIR = "Library"

mp3_files = Dir.glob("*.mp3")

puts "Cleaning up backup directory..."
FileUtils.rm_rf(BACKUP_DIR)

puts "Backing up mp3s..."
FileUtils.mkdir(BACKUP_DIR)
FileUtils.cp(mp3_files, BACKUP_DIR)

def scrub_invalid(str)
  str.gsub(/\//, '-')
end

puts "Organizing mp3s..."
mp3_files.each do |f|
  mp3 = File.open(f, "rb")
  tag = ID3Tag.read(mp3)

  required_attrs = [:track_nr, :artist, :album, :title]

  if required_attrs.any? { |a| tag.public_send(a).nil? }
    puts "Skipping #{f}, missing required metadata"
    next
  end

  track_num = tag.track_nr.split("/").first
  artist = scrub_invalid(tag.artist)
  album = scrub_invalid(tag.album)
  title = scrub_invalid(tag.title)

  dir = "#{LIB_DIR}/#{artist}/#{album}"
  FileUtils.mkdir_p(dir)

  FileUtils.mv(f, "#{dir}/#{track_num} - #{title}.#{f.split(".").last}")
end

puts "mp3s organized into #{LIB_DIR}"
