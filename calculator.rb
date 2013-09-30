class Calculator

  attr_accessor :args
  
  def initialize(*args)
    @args = args
  end

  def plus
    @args.select { |el| el.is_a?(Numeric)}.inject(0, &:+)
  end

  def minus
    @args.select { |el| el.is_a?(Numeric)}.inject(0, &:-)
  end

  def clear
  	@args.clear
  end

end