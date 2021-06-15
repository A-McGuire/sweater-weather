# Sweater Weather API
Sweater Weather is a back end application designed to serve a front end application with weather data for road trips.

### External APIs

### Learning Goals

### This project was built with:

* Ruby version - 2.5.3
* Rails version - 5.2.6
* RSpec version - 3.10

### Set-up Instructions

### Endpoints

##### Forecast
Example request:
  ```
    GET /api/v1/forecast?location=denver,co
    Content-Type: application/json
    Accept: application/json
  ```
  
Example response:
  ```
    {
      "data": {
        "id": null,
        "type": "forecast",
        "attributes": {
          "current_weather": {
            "datetime": "2020-09-30 13:27:03 -0600",
            "temperature": 79.4,
            etc
          },
          "daily_weather": [
            {
              "date": "2020-10-01",
              "sunrise": "2020-10-01 06:10:43 -0600",
              etc
            },
            {...} etc
          ],
          "hourly_weather": [
            {
              "time": "14:00:00",
              "conditions": "cloudy with a chance of meatballs",
              etc
            },
            {...} etc
          ]
        }
      }
    }
  ```

##### Backgrounds
Example Request:  
  ```
    GET /api/v1/backgrounds?location=denver,co
    Content-Type: application/json
    Accept: application/json
  ```

Example response:  
  ```
    "data": {
            "id": null,
            "type": "image",
            "attributes": {
                "image": {
                    "location": "denver, co",
                    "image_url_full": "https://images.unsplash.com/photo-1619856699906-09e1f58c98b1?crop=entropy&cs=srgb&fm=jpg&ixid=MnwyMzkzMDV8MHwxfHNlYXJjaHwxfHxkZW52ZXIlMkMlMjBjb3xlbnwwfHx8fDE2MjM3OTczNzk&ixlib=rb-1.2.1&q=85",
                    "image_url_regular": "https://images.unsplash.com/photo-1619856699906-09e1f58c98b1?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyMzkzMDV8MHwxfHNlYXJjaHwxfHxkZW52ZXIlMkMlMjBjb3xlbnwwfHx8fDE2MjM3OTczNzk&ixlib=rb-1.2.1&q=80&w=1080",
                    "image_url_small": "https://images.unsplash.com/photo-1619856699906-09e1f58c98b1?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyMzkzMDV8MHwxfHNlYXJjaHwxfHxkZW52ZXIlMkMlMjBjb3xlbnwwfHx8fDE2MjM3OTczNzk&ixlib=rb-1.2.1&q=80&w=400",
                    "image_url_thumb": "https://images.unsplash.com/photo-1619856699906-09e1f58c98b1?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyMzkzMDV8MHwxfHNlYXJjaHwxfHxkZW52ZXIlMkMlMjBjb3xlbnwwfHx8fDE2MjM3OTczNzk&ixlib=rb-1.2.1&q=80&w=200",
                    "credit": {
                        "source": "unsplash.com",
                        "author": "rdehamer",
                        "author_profile": "https://api.unsplash.com/users/rdehamer"
                    }
                }
            }
        }
    }
  ```
  
##### User Registration
Example Request:  
  ```
    POST /api/v1/users
    Content-Type: application/json
    Accept: application/json

    {
      "email": "123@example.com",
      "password": "verystrongpassword",
      "password_confirmation": "verystrongpassword"
    }
  ```

Example response:  
  ```
    {
      "data": {
          "id": "2",
          "type": "users",
          "attributes": {
              "email": "123@example.com",
              "api_key": "dnunhHUTL8j8crs68PhuEfqx"
          }
       }
    }
  ```
  
##### User Login
Example Request:  
  ```
    POST /api/v1/sessions
    Content-Type: application/json
    Accept: application/json

    {
    "email": "123@example.com",
    "password": "verystrongpassword"
    }
  ```

Example response:  
  ```
    {
        "data": {
            "id": "2",
            "type": "users",
            "attributes": {
                "email": "123@example.com",
                "api_key": "dnunhHUTL8j8crs68PhuEfqx"
            }
        }
    }
  ```
  
##### Road Trip
Example Request:  
  ```
    {
      "origin": "Denver,CO",
      "destination": "New York, NY",
      "api_key": "dnunhHUTL8j8crs68PhuEfqx"
    }
  ```

Example response:  
  ```
    {
        "data": {
            "id": null,
            "type": "roadtrip",
            "attributes": {
                "start_city": "Denver,CO",
                "end_city": "New york, NY",
                "travel_time": "26:16:46",
                "weather_at_eta": {
                    "temperature": 70.47,
                    "conditions": "clear sky"
                }
            }
        }
    }
  ```
  

### Testing
