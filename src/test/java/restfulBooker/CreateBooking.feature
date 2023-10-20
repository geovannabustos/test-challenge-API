@CreateBooking
Feature: Booking - CreateBooking

  @CreateBookingSuccessful @HappyPaths
  Scenario Outline: Create a new booking in the API
    * def entrant =
    """
    {
      "firstname" : <firstname>,
      "lastname" : <lastname>,
      "totalprice" : <totalprice>,
      "depositpaid" : <depositpaid>,
      "bookingdates" : {
          "checkin" : <checkin>,
          "checkout" : <checkout>
      },
      "additionalneeds" : <additionalneeds>
    }
    """
    Given url 'https://restful-booker.herokuapp.com/booking'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And request entrant
    When method POST
    Then status 200
    And match response ==
    """
    {
        "bookingid": '#number',
        "booking": {
            "firstname": '#string',
            "lastname": '#string',
            "totalprice": '#number',
            "depositpaid": '#boolean',
            "bookingdates": {
                "checkin": '#string',
                "checkout": '#string'
            },
            "additionalneeds": '#string'
        }
    }
    """
    And match response.booking.firstname == entrant.firstname
    And match response.booking.lastname == entrant.lastname
    And match response.booking.totalprice == entrant.totalprice
    And match response.booking.depositpaid == entrant.depositpaid
    And match response.booking.bookingdates.checkin == entrant.bookingdates.checkin
    And match response.booking.bookingdates.checkout == entrant.bookingdates.checkout
    And match response.booking.additionalneeds == entrant.additionalneeds
    Examples:
      | firstname | lastname | totalprice | depositpaid | checkin      | checkout     | additionalneeds |
      | 'Jim'     | 'Brown'  | 111        | true        | '2018-01-01' | '2018-01-01' | 'Breakfast'     |

  @CreateBookingFailed @UnHappyPathss
  Scenario Outline: Create a new booking in the API failed due to parameter error
    * def entrant =
    """
    {
        "firstname" : <firstname>,
        "lastname" : <lastname>,
        "totalprice" : <totalprice>,
        "depositpaid" : <depositpaid>,
        "bookingdates" : {
            "checkin" : <checkin>,
            "checkout" : <checkout>
        },
        "additionalneeds" : <additionalneeds>
    }
    """
    Given url 'https://restful-booker.herokuapp.com/booking'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And request entrant
    When method POST
    Then status 400
    Examples:
      | firstname | lastname | totalprice | depositpaid | checkin      | checkout     | additionalneeds |
      | ''        | 'Brown'  | 111        | true        | '2018-01-01' | '2018-01-01' | 'Breakfast'     |
      | 'Jim'     | ''       | 111        | true        | '2018-01-01' | '2018-01-01' | 'Breakfast'     |
      | 'Jim'     | 'Brown'  |            | true        | '2018-01-01' | '2018-01-01' | 'Breakfast'     |
      | 'Jim'     | 'Brown'  | 111        |             | '2018-01-01' | '2018-01-01' | 'Breakfast'     |
      | 'Jim'     | 'Brown'  | 111        | true        | ''           | '2018-01-01' | 'Breakfast'     |
      | 'Jim'     | 'Brown'  | 111        | true        | '2018-01-01' | ''           | 'Breakfast'     |
      | 'Jim'     | 'Brown'  | 111        | true        | '2018-01-01' | '2018-01-01' | ''              |
