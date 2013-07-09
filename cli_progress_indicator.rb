require File.dirname(__FILE__) + '/progress_indicator'

class CliProgressIndicator < ProgressIndicator
  def i_progress(percent, message)
    p = percent.to_i
    puts "#{' ' * (3 - p.to_s.length)}#{p}% #{message}"
  end

  def error(message)
    puts "!!!! #{message}"
  end

  def unknown_progress(message)
    puts ".... #{message}"
  end

  def title(title)
    puts "#{title}"
    puts "=" * title.length
    puts ""
  end
end