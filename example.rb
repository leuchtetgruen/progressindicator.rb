#!/usr/bin/ruby
$: << "."
require 'curses_progress_indicator'
require 'cli_progress_indicator'
require 'remote_progress_indicator'

options = ['curses', 'cli', 'remote']
if (ARGV.length < 1) or (!options.include? ARGV[0]) then
  puts "\nError - invalid nr of arguments."
  puts "Usage: example.rb [#{options.join('|')}]\n\n"
end


pi =  case ARGV[0]
      when 'curses':
        CursesProgressIndicator.new("Test")
      when 'cli':
        CliProgressIndicator.new("Test")
      when 'remote':
        RemoteProgressIndicator.new("Test")
      end
      
# This simple step takes 10% of the time
pi.step "Step 1", 10 do |_pi|
  sleep 1
end

# This complicated step will take 80% of the time
# and will therefore have substeps
pi.step "Step 2 (Might take a while)", 80 do |_pi|
  process_me = (1..100).to_a
  
  # Set message and number of steps for this subtask
  # and tell it to only emit a message every 5 steps
  _pi.set_subtotal(process_me.size, "Step 2", 5)
  process_me.each do |i|
    _pi.increase_sub
    sleep 0.05
  end
end

pi.done "We're done"