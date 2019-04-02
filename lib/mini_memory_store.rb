# frozen_string_literal: true
class MiniMemoryStore
  def initialize(expires_in:)
    @expires_in = expires_in
    @last_set = 0
  end

  def set(value)
    @last_set = now
    @value = value
  end

  def get
    if expired?
      nil
    else
      @value
    end
  end

  def cache
    value = get
    if value.nil?
      value = yield
      set value
    end
    value
  end

  def clear
    set nil
  end

  private

  def expired?
    (now - @expires_in) >= @last_set
  end

  def now
    Process.clock_gettime(Process::CLOCK_MONOTONIC)
  end
end
