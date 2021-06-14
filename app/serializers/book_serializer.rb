class BookSerializer
  include FastJsonapi::ObjectSerializer
  set_type :books
  attributes :destination, :forecast, :total_books_found, :books
end
