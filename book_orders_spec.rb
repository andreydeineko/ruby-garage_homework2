require 'rspec'
require_relative 'book_orders.rb'

describe BookOrder do
	
  before do
  	@clients = [ Client.new('John'), Client.new('Max') ]
  	@books = [ Book.new('book1'), Book.new('book2'), Book.new('book3') ]
  	@book_orders = [ BookOrder.new(Time.now - 3600, Time.now, @clients[0], @books[0]), BookOrder.new(Time.now - 10, Time.now, @clients[0], @books[1]), 
  					 BookOrder.new(Time.now - 4600, Time.now, @clients[1], @books[0]), BookOrder.new(Time.now - 3700, Time.now, @clients[1], @books[2]) ]
     end

  it 'counts issuence time for particular order' do
  	@book_orders.first.issuence_time.to_i.should == 3600
  end

  it 'counts not satisfied orders' do
 	BookOrder.not_satisfied_orders(*@book_orders).should == 0
  end

  it 'counts the smallest issuence period' do
  	BookOrder.smallest_issuence_period(*@book_orders).should == 10
  end

  it 'looks for client who often takes books' do
  	BookOrder.often_takes_books(*@book_orders).should == [ @book_orders[0].client, @book_orders[2].client ]
  end

  it 'finds the most popular book' do
  	BookOrder.most_popular_book(*@book_orders).should == @book_orders.first.book
  end

  it 'finds clients who ordered the most popular book' do
  	BookOrder.clients_who_ordered_most_popular_book(*@book_orders).should == 2
  end

end

# @book_orders = [ BookOrder.new((Time.now - 3600), Time.now,  		 Client.new("John"), Book.new('book1')), 
 # 		 			 BookOrder.new(Time.now - 10,	  Time.now, 	 	 Client.new("John"), Book.new('book2')), 
  #		 			 BookOrder.new((Time.now - 4600), Time.now, 	     Client.new("Max"), Book.new('book1')),
  #		 			 BookOrder.new(Time.now - 3700, Time.now, 		 	 Client.new("Max"),  Book.new('book3')), ]

