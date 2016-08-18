#!/usr/bin/env ruby

require "optparse"
require "date"

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: changes.rb [options]"
  opts.on("-dDir", "--directory=DIRECTORY", "Choose specific project to summarize") do |d|
    options[:directory] = d
  end

  opts.on("-h", "--help", "Print all commands.") do
    puts opts
    exit
  end
end.parse!

def changes options
  today = Date.today
  filename = "reports/for_science/" + today.to_s + ".md"
  if File.exist?(filename)
    if options[:directory].nil?
      dir = "reports/for_science"
    else
      dir = "reports/" + options[:directory]
    end
    Dir[dir]
    reports = Dir.glob(dir + "/*.md")
    todayFile = File.read(reports[-1]).split(" ")
    lastAvailable = File.read(reports[-2]).split(" ")
    changes = todayFile[0].to_i - lastAvailable[0].to_i
    puts "Total changes:" + changes.to_s
    puts "Last Available Report: " + lastAvailable[0] + ", Today's Report: " + todayFile[0]
  else
    puts "Error: today's report haven't been generated."
  end
end

changes(options)
