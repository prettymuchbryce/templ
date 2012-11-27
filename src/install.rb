require 'open-uri'
require 'fileutils'
include FileUtils

cd("/usr/local/bin")

puts "Installing templ.."

File.open("/usr/local/bin/templ", "wb") do |saved_file|
  # the following "open" is provided by open-uri
  open("https://raw.github.com/prettymuchbryce/templ/master/src/templ.rb", 'rb') do |read_file|
    saved_file.write(read_file.read)
  end
end

chmod("+x", "templ")

puts "Installation complete. Type templ help to get started."