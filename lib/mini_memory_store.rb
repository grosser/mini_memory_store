class MiniMemoryStore
  VERSION = File.read( File.join(File.dirname(__FILE__),'..','VERSION') ).strip

  def initialize(options={})
    @options = options
    @last_set = 0
  end

  def set(value)
    @last_set = Time.now.to_i
    @value = value
  end

  def get
    if expired?
      nil
    else
      @value
    end
  end

  def cache(&block)
    value = get
    if value.nil?
      value = block.call
      set(value)
      value
    else
      value
    end
  end

  def clear
    set nil
  end

  private

  def expired?
    return unless @options[:expires_in]
    (Time.now.to_i - @options[:expires_in]) >= @last_set
  end
end