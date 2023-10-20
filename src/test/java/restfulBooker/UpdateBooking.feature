@UpdateBooking
Feature: Booking - UpdateBooking

  @UpdateBookingSuccessful @HappyPaths
  Scenario Outline: Update a current booking
    * def authToken = call read('Auth.feature@CreateTokenSuccessful')
    * def tokenValue = authToken.response.token
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
    Given url 'https://restful-booker.herokuapp.com/booking/<id>'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And header Cookie = 'token='+ tokenValue
    And request entrant
    When method PUT
    Then status 200
    And match response ==
    """
    {
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
    """
    And match response.firstname == entrant.firstname
    And match response.lastname == entrant.lastname
    And match response.totalprice == entrant.totalprice
    And match response.depositpaid == entrant.depositpaid
    And match response.bookingdates.checkin == entrant.bookingdates.checkin
    And match response.bookingdates.checkout == entrant.bookingdates.checkout
    And match response.additionalneeds == entrant.additionalneeds
    Examples:
      | id | firstname |  | lastname | totalprice | depositpaid | checkin      | checkout     | additionalneeds |
      | 1  | 'Jim'     |  | 'Brown'  | 111        | true        | '2018-01-01' | '2018-01-01' | 'Breakfast'     |

  @UpdateBookingFailed @UnHappyPathss
  Scenario Outline: Update a current booking failed due to parameter error
    * def authToken = call read('Auth.feature@CreateTokenSuccessful')
    * def tokenValue = authToken.response.token
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
    Given url 'https://restful-booker.herokuapp.com/booking/<id>'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And header Cookie = 'token='+ tokenValue
    And request entrant
    When method PUT
    Then status 400
    Examples:
      | id  | firstname | lastname | totalprice | depositpaid | checkin      | checkout     | additionalneeds |
      | 1   | ''        | 'Brown'  | 111        | true        | '2018-01-01' | '2018-01-01' | 'Breakfast'     |
      | 1   | 'Jim'     | ''       | 111        | true        | '2018-01-01' | '2018-01-01' | 'Breakfast'     |
      | 1   | 'Jim'     | 'Brown'  |            | true        | '2018-01-01' | '2018-01-01' | 'Breakfast'     |
      | 1   | 'Jim'     | 'Brown'  | 111        |             | '2018-01-01' | '2018-01-01' | 'Breakfast'     |
      | 1   | 'Jim'     | 'Brown'  | 111        | true        | ''           | '2018-01-01' | 'Breakfast'     |
      | 1   | 'Jim'     | 'Brown'  | 111        | true        | '2018-01-01' | ''           | 'Breakfast'     |
      | 1   | 'Jim'     | 'Brown'  | 111        | true        | '2018-01-01' | '2018-01-01' | ''              |
      | -1  | 'Jim'     | 'Brown'  | 111        | true        | '2018-01-01' | '2018-01-01' | 'Breakfast'     |
      | 0   | 'Jim'     | 'Brown'  | 111        | true        | '2018-01-01' | '2018-01-01' | 'Breakfast'     |
      | uno | 'Jim'     | 'Brown'  | 111        | true        | '2018-01-01' | '2018-01-01' | 'Breakfast'     |


  @UpdateBookingFailedIdIncorrect @UnHappyPathss
  Scenario Outline: Update a current booking failed due to id incorrect
    * def authToken = call read('Auth.feature@CreateTokenSuccessful')
    * def tokenValue = authToken.response.token
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
    Given url 'https://restful-booker.herokuapp.com/booking/<id>'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And header Cookie = 'token='+ tokenValue
    And request entrant
    When method PUT
    Then status 405
    And match response == 'Method Not Allowed'
    Examples:
      | id  | firstname | lastname | totalprice | depositpaid | checkin      | checkout     | additionalneeds |
      | -1  | 'Jim'     | 'Brown'  | 111        | true        | '2018-01-01' | '2018-01-01' | 'Breakfast'     |
      | 0   | 'Jim'     | 'Brown'  | 111        | true        | '2018-01-01' | '2018-01-01' | 'Breakfast'     |
      | uno | 'Jim'     | 'Brown'  | 111        | true        | '2018-01-01' | '2018-01-01' | 'Breakfast'     |

  @UpdateBookingFailedTokenIncorrect @UnHappyPathss
  Scenario Outline: Update a current booking failed due to token incorrect
    * def tokenValue = 'c3a732fd54119bb'
    * def entrant = {}
    Given url 'https://restful-booker.herokuapp.com/booking/<id>'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And header Cookie = 'token='+ tokenValue
    And request entrant
    When method PUT
    Then status 403
    And match response == 'Forbidden'
    Examples:
      | id |
      | 1  |

  @UpdateBookingFailedCookieMissing @UnHappyPathss
  Scenario Outline: Update a current booking failed due to cookie missing
    * def entrant = {}
    Given url 'https://restful-booker.herokuapp.com/booking/<id>'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And request entrant
    When method PUT
    Then status 403
    And match response == 'Forbidden'
    Examples:
      | id |
      | 1  |
