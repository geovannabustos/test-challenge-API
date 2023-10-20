@GetBooking
Feature: Booking - GetBooking

  @GetBookingSuccessful @HappyPaths
  Scenario Outline: Obtain a specific booking based upon the booking id provided
    Given url 'https://restful-booker.herokuapp.com/booking/<id>'
    And header Accept = 'application/json'
    When method GET
    Then status 200
    And match response.firstname == '#string'
    And match response.lastname == '#string'
    And match response.totalprice == '#number'
    And match response.depositpaid == '#boolean'
    And match response.bookingdates.checkin == '#string'
    And match response.bookingdates.checkout == '#string'
    And match response.additionalneeds == '#string'
    Examples:
      | id |
      | 1  |

  @GetBookingFailed @UnHappyPathss
  Scenario Outline: Obtain a specific booking based upon the booking id provided failed due to parameter error
    Given url 'https://restful-booker.herokuapp.com/booking/<id>'
    And header Accept = 'application/json'
    When method GET
    Then status 404
    And match response == 'Not Found'
    Examples:
      | id  |
      | 0   |
      | -1  |
      | uno |