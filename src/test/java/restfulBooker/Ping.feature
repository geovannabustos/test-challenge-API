@Ping
Feature: Ping - HealthCheck

  @PinHealthCheckSuccessful @HappyPaths
  Scenario: A simple health check endpoint to confirm whether the API is up and running
    Given url 'https://restful-booker.herokuapp.com/ping'
    When method GET
    Then status 201
    And match response == 'Created'






