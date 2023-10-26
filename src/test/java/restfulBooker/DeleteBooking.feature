@DeleteBooking
Feature: Booking - DeleteBooking

  @DeleteBookingSuccessful @HappyPaths
  Scenario Outline: Obtain the ids of all the bookings that exist within the API
    * def authToken = call read('Auth.feature@CreateTokenSuccessful')
    * def tokenValue = authToken.response.token
    Given url 'https://restful-booker.herokuapp.com/booking/<id>'
    And header Content-Type = 'application/json'
    And header Cookie = 'token='+ tokenValue
    When method DELETE
    Then status 201
    And match response == 'Created'
    Examples:
      | id |
      | 8  |

  @DeleteBookingFailed @UnHappyPaths
  Scenario Outline: Obtain the ids of all the bookings that exist within the API failed due to parameter error
    * def authToken = call read('Auth.feature@CreateTokenSuccessful')
    * def tokenValue = authToken.response.token
    Given url 'https://restful-booker.herokuapp.com/booking/<id>'
    And header Content-Type = 'application/json'
    And header Cookie = 'token='+ tokenValue
    When method DELETE
    Then status 405
    And match response == 'Method Not Allowed'
    Examples:
      | id |
      | -1 |
      | 0  |

  @DeleteBookingFailedTokenIncorrect @UnHappyPaths
  Scenario Outline: Obtain the ids of all the bookings that exist within the API failed due to token incorrect
    * def tokenValue = 'c3a732fd54119bb'
    Given url 'https://restful-booker.herokuapp.com/booking/<id>'
    And header Content-Type = 'application/json'
    And header Cookie = 'token='+ tokenValue
    When method DELETE
    Then status 403
    And match response == 'Forbidden'
    Examples:
      | id |
      | 1  |

  @DeleteBookingFailedCookieMissing @UnHappyPaths
  Scenario Outline: Obtain the ids of all the bookings that exist within the API failed due to cookie missing
    Given url 'https://restful-booker.herokuapp.com/booking/<id>'
    And header Content-Type = 'application/json'
    When method DELETE
    Then status 403
    And match response == 'Forbidden'
    Examples:
      | id |
      | 1  |

