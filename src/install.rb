require 'net/http'
require 'fileutils'
include FileUtils

cd("/usr/local/bin")

puts "Installing templ.."

Net::HTTP.start("raw.github.com") do |http|
    resp = http.get("/prettymuchbryce/templ/master/bin/templ")
    open("templ", "wb") do |file|
        file.write(resp.body)
    end
end

puts "Installation complete. Restart your terminal, and type templ help to get started."