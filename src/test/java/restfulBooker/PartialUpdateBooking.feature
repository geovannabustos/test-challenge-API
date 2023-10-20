@PartialUpdateBooking
Feature: Booking - PartialUpdateBooking

  @PartialUpdateBookingSuccessful @HappyPaths
  Scenario Outline: Update a current booking with a partial payload
    * def authToken = call read('Auth.feature@CreateTokenSuccessful')
    * def tokenValue = authToken.response.token
    * def entrant =
    """
    {
      "firstname" : <firstname>,
      "lastname" : <lastname>
    }
    """
    Given url 'https://restful-booker.herokuapp.com/booking/<id>'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And header Cookie = 'token='+ tokenValue
    And request entrant
    When method PATCH
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
    Examples:
      | id | firstname |  | lastname   |
      | 11 | 'JimTwo'  |  | 'BrownTwo' |

  @PartialUpdateBookingFailed @UnHappyPathss
  Scenario Outline: Update a current booking with a partial payload faild due to parameter error
    * def authToken = call read('Auth.feature@CreateTokenSuccessful')
    * def tokenValue = authToken.response.token
    * def entrant =
    """
    {
      "firstname" : <firstname>,
      "lastname" : <lastname>
    }
    """
    Given url 'https://restful-booker.herokuapp.com/booking/<id>'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And header Cookie = 'token='+ tokenValue
    And request entrant
    When method PATCH
    Then status 400
    Examples:
      | id | firstname |  | lastname   |
      | 11 | ''        |  | 'BrownTwo' |
      | 11 | 'JimTwo'  |  | ''         |

  @PartialUpdateBookingFailedEntrantEmpty @UnHappyPathss
  Scenario Outline: Update a current booking with a partial payload faild due to entrant empty
    * def authToken = call read('Auth.feature@CreateTokenSuccessful')
    * def tokenValue = authToken.response.token
    * def entrant = {}
    Given url 'https://restful-booker.herokuapp.com/booking/<id>'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And header Cookie = 'token='+ tokenValue
    And request entrant
    When method PATCH
    Then status 400
    Examples:
      | id |
      | 11 |

  @PartialUpdateBookingFailedTokenIncorrect @UnHappyPathss
  Scenario Outline: Update a current booking with a partial payload faild due to token incorrect
    * def tokenValue = 'c3a732fd54119bb'
    * def entrant = {}
    Given url 'https://restful-booker.herokuapp.com/booking/<id>'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And header Cookie = 'token='+ tokenValue
    And request entrant
    When method PATCH
    Then status 403
    And match response == 'Forbidden'
    Examples:
      | id |
      | 11 |

  @PartialUpdateBookingFailedCookieMissing @UnHappyPathss
  Scenario Outline: Update a current booking with a partial payload faild due to cookie missing
    * def entrant = {}
    Given url 'https://restful-booker.herokuapp.com/booking/<id>'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And request entrant
    When method PATCH
    Then status 403
    And match response == 'Forbidden'
    Examples:
      | id |
      | 11 |