class BookFacade
  class << self
    def location_book_data(location, quantity)
      forcast = ForcastFacade.location_weather_data(location)
      books = OpenLibraryService.get_location_books(location, quantity)
      books = {
        destination: location,
        forcast: {
          summary: forcast.current_weather[:conditions],
          temperature: "#{forcast.current_weather[:temperature]} F"
        },
        total_books_found: books[:numFound],
        books: books[:docs].map do |book|
          {
            isbn: book[:isbn],
            title: book[:title],
            publisher: book[:publisher]
          }
        end
      }

      OpenStruct.new(id: nil, data: books)
    end
  end
end
