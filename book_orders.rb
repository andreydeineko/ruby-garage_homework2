# TASK

# In library each book order includes information about reader: name, order date, issue date. 
# Write program that determines: 
# 1) the smallest period for which library found a book 
# 2) how many orders were not satisfied 
# 3) who often takes the book 
# 4) what is the most popular book 
# 5) how many people ordered one of the three most popular books.


class Client

  attr_accessor :name

  def initialize(name)
  	@name = name
  end

end

class Book

  attr_accessor :title

  def initialize(title)
  	@title = title
  end

end

class BookOrder

  attr_accessor :order_date, :issue_date, :client, :book

  def initialize(order_date, issue_date, client, book)
    raise 'Order date is not a "Time" object' unless order_date.is_a?(Time)
    raise 'Issue date is not a "Time" object' unless issue_date.is_a?(Time)
    raise 'issue_date should be greater then odrer_date' if issue_date <= order_date
	  @order_date, @issue_date, @client, @book = order_date, issue_date, client, book
  end

  def issuence_time
    @issue_date - @order_date
  end
  
  def not_satisfied?
   issue_date <= order_date
 end

  def self.smallest_issuence_period(*book_orders)
    book_orders.map { |book_order| book_order.issuence_time }.min.to_i    # checks for the minimum value of issuence_time
  end

  def self.not_satisfied_orders(*book_orders)
    book_orders.select { |book_order| book_order.not_satisfied? }.count
  end

  def self.often_takes_books(*book_orders)
    stats = book_orders.inject({}) do |memo, book_order|                  # memo is a hash
      memo[book_order.client] ||= 0                                       # if there is no client who previously ordered the book - it eq to 0 
      memo[book_order.client] += 1                                        # if there is, it adds one to it
      memo                                                                
    end

    max_orders_count = stats.max_by { |key, value| value }.last           # looks for maximum value in the stats hash
    clients          = book_orders.map(&:client)                          # clients in our case are attributes of bookOrder class instances

    clients.select { |client| stats[client] == max_orders_count }.uniq         # selects the clients from the stats hash and returns the names of those, whose order count is max 
    #clients = clients.uniq { |client| client.name } 
  end

  def self.most_popular_book(*book_orders)                                # pretty much the same as previuos method, with the only difference that this one finds the only
    stats = book_orders.inject({}) do |memo, book_order|                  # one most popular book
      memo[book_order.book] ||= 0
      memo[book_order.book] += 1
      memo
    end

    max_books_count = stats.max_by { |key, value| value }.last
    books           = book_orders.map(&:book)

    books.find { |book| stats[book] == max_books_count }
  end

  def self.clients_who_ordered_most_popular_book(*book_orders)              
    popular_book = most_popular_book(*book_orders)                         # we assign the most popular book found on method most_popular_book to a popular_book variable
    popular_book_orders = book_orders.select { |book_order| book_order.book == popular_book } # we select those books in orders, which equals to the most popular book
    popular_book_orders.uniq { |popular_book_order| popular_book_order.client }.count         # here we count unique clients who ordered the most popular book
  end                                                                                         # that is if the most popular book is "Book1" and client John ordrered this
                                                                                              # book more than once, we dont need his name counted more than once
end