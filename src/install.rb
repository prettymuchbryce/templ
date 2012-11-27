require 'net/http'
require 'fileutils'

cd("/usr/bin/local")

puts "Installing templ.."

Net::HTTP.start("raw.github.com") do |http|
    resp = http.get("/prettymuchbryce/templ/bin/templ")
    open("templ", "wb") do |file|
        file.write(resp.body)
    end
end

puts "Installation complete. Restart your terminal, and type templ help to get started."