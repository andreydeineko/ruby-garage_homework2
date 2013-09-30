require 'rspec'
require_relative 'calculator.rb'

describe "Calculator" do
  
  before do
  	@calc = Calculator.new(1, 3.5, nil, :hello, "world")
  end
  
  it 'clears array' do
  	@calc.args.should_not == []
  	@calc.clear.should == []
  end

  it 'adds numbers' do
  	@calc.plus.should == 4.5
  end

  it 'substracts numbers' do
  	@calc.minus.should == -4.5
  end

end