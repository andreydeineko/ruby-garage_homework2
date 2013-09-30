require 'rspec'
require_relative 'mail_sorting.rb'

describe "MailSorting" do
	
  before do
  	@parcels = [ MailSorting.new("city1", "street1", "house1", "apartment1", "destination1", 4), MailSorting.new("city2", "street2", "house2", "apartment2", "destination2", 9),
  	             MailSorting.new("city2", "street1", "house3", "apartment3", "destination3", 12) ]
  end

  it 'counts number of parcels sent to some city' do
  	MailSorting.number_of_parcels_sent_to_city(@parcels, "city2").should == 2 
  end 

  it "checks if parcel's value is higher than 10" do
  	@parcels.last.value_greater_then_10?.should be_true
  end

  it 'counts amount of parcels with value higher than 10' do
  	parcels = @parcels
  	MailSorting.amount_of_parcels_with_value_greater_then_10_were_sent(*parcels).should == 1
  end

  it 'finds the most popular address' do
  	parcels = @parcels
  	MailSorting.most_popular_address(*parcels).should == "street1"
  end

end