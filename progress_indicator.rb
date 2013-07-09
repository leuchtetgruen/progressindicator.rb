

class ProgressIndicator

  WEBSOCKET_INDICATOR = ":;:"
  
  def initialize(title="", total=100)
    if (title!="") then
      title(title)
    end
    @total = total
    @p = 0

    @sub_total = 100
    @sp = 0
    @sub_total_equals_percent = 0
    @sub_message = ""
    @sub_emit_message_every = 100
  end
  
  
  def set_total(t)
    @total = t
  end
  
  def set_subtotal(t, sub_message, emit_message_every=1)
    @sp = 0
    @sub_total = t
    @sub_message = sub_message
    @sub_emit_message_every = emit_message_every
  end
  
  def reset_sub
    @sp = 0
  end
  
  def finalize_sub
    @p += @sub_total_equals_percent
    reset_sub
  end
  
  def increase(by=1)
    @p += by
  end
  
  def increase_sub(by=1)
    @sp += by
    
    if ((@sp % @sub_emit_message_every) == 0) then
      progress("#{@sub_message} (#{(@sp.to_f * 100 / @sub_total.to_f).to_i}%)")
    end
  end
  
  def step(message, total_step_progress)
    progress(message)
    @sub_total_equals_percent = total_step_progress
    yield self
    finalize_sub
  end

  def progress(message)
    percent = @p + ((@sp.to_f / @sub_total.to_f) * @sub_total_equals_percent)
    i_progress(percent, message)
  end
  
  def done(message="Fertig")
    @p = 100
    i_progress(@p, message)
  end

  # TODO subclasses will have to implement this
  def i_progress(percent, message)
    raise NotImlementedError
  end

  def error(message)
    raise NotImlementedError    
  end

  def unknown_progress(message)
    raise NotImlementedError  
  end

  def title(title)
    raise NotImlementedError    
  end
  
end