@GetBookingIds
Feature: Booking - GetBookingIds

  @GetBookingIdsSuccessful @HappyPaths
  Scenario: Obtain the identifiers of all reservations that exist within the API
    Given url 'https://restful-booker.herokuapp.com/booking'
    When method GET
    Then status 200
    And match response == '#array'
    And match response == '##[_ > 0]'
    And def res = karate.match("response contains { bookingid: '#number' }")
    And match res == { pass: true, message: null }

  @GetBookingIdsSuccessfulFilterByName @HappyPaths
  Scenario: Obtain the identifiers of all reservations that exist within the API filter by name
    Given url 'https://restful-booker.herokuapp.com/booking'
    And header firstname = 'GEOVANNA'
    And header lastname = 'BUSTOS'
    When method GET
    Then status 200
    And match response == '#array'
    And match response == '##[_ > 0]'
    And def res = karate.match("response contains { bookingid: '#number' }")
    And match res == { pass: true, message: null }

  @GetBookingIdsSuccessfulFilterByCheckinCheckoutDate @HappyPaths
  Scenario: Obtain the identifiers of all reservations that exist within the API filter by CheckinCheckout date
    Given url 'https://restful-booker.herokuapp.com/booking'
    And header checkin = '2023-10-19'
    And header checkout = '2023-10-19'
    When method GET
    Then status 200
    And match response == '#array'
    And match response == '##[_ > 0]'
    And def res = karate.match("response contains { bookingid: '#number' }")
    And match res == { pass: true, message: null }

  @GetBookingIdsSuccessfulFilterFailed @UnHappyPaths
  Scenario: Obtain the identifiers of all reservations that exist within the API failed
    Given url 'https://restful-booker.herokuapp.com/booking'
    And header firstname = ''
    And header lastname = ''
    And header checkin = ''
    And header checkout = ''
    When method GET
    Then status 400

