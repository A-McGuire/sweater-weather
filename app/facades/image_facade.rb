class ImageFacade
  class << self
    def location_image_data(location)
      data = UnsplashService.get_location_image(location)
      backgrounds = {
        location: location,
        image_url_full: data[:results].first[:urls][:full],
        image_url_regular: data[:results].first[:urls][:regular],
        image_url_small: data[:results].first[:urls][:small],
        image_url_thumb: data[:results].first[:urls][:thumb],
        credit: {
          source: 'unsplash.com',
          author: data[:results].first[:user][:username],
          author_profile: data[:results].first[:user][:links][:self]
        }
      }

      OpenStruct.new(id: nil, image: backgrounds)
    end
  end
end
