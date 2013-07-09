require File.dirname(__FILE__) + '/progress_indicator'

class RemoteProgressIndicator < ProgressIndicator
  def i_progress(percent, message)
    puts "#{WEBSOCKET_INDICATOR}PROGRESS#{WEBSOCKET_INDICATOR}#{percent.to_s}#{WEBSOCKET_INDICATOR}#{message}"
  end

  def error(message)
    puts "#{WEBSOCKET_INDICATOR}ERROR#{WEBSOCKET_INDICATOR}#{message}"
  end

  def unknown_progress(message)
    puts "#{WEBSOCKET_INDICATOR}UNKNOWN_PROGRESS#{WEBSOCKET_INDICATOR}#{message}"
  end

  def title(title) 
    puts "#{WEBSOCKET_INDICATOR}TITLE#{WEBSOCKET_INDICATOR}#{title}"
  end
end