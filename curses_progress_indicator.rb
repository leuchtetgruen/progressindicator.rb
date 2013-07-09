require "curses"
require File.dirname(__FILE__) + '/progress_indicator'

class CursesProgressIndicator < ProgressIndicator
  def initialize(title="", total=100)
    
    Curses::init_screen
    @winwidth = 100    
    @win = Curses::Window.new(6, @winwidth, (Curses::lines - 6) / 2, (Curses::cols-@winwidth) / 2)
    @win.color_set(7)

    @title = "=#{title}="
    
    super title, total
  end
  
  def i_progress(percent, message)
    #write title
    Curses::clear
    Curses::refresh
    @win.clear
    @win.box(?|, ?-)    
    @win.setpos(0, (@winwidth-@title.length)/2)
    @win.addstr(@title)

    #write progress
    if (percent > 0) then
      percent_width = (percent.to_f / 100.to_f *  (@winwidth - 6)).to_i
      n_spaces = @winwidth - 6 - percent_width
      strProgress = "[#{'#'*percent_width}#{' '*n_spaces}]"
      @win.setpos(2, 2)
      @win.addstr(strProgress)
    end

    #write message
    @win.setpos(3, (@winwidth-message.length)/2)  
    @win.addstr(message)

    @win.refresh
  end
  
  def error(message)
    #write message
    msg = "!! #{message} !!"
    @win.setpos(3, (@winwidth-msg.length)/2)  
    @win.color_set(15)
    @win.addstr(msg)
    @win.color_set(7)
    @win.refresh
  end

  def unknown_progress(message)
    i_progress(-1, message)
  end

  def title(title)
    @title = title
  end
  
  def done(message="Fertig")
    super(message)
    @win.getch
    Curses::close_screen
  end
  
end

