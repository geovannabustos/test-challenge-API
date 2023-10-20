@CreateToken
Feature: Auth - CreateToken

  @CreateTokenSuccessful @HappyPaths
  Scenario: Creates a new auth token
    * def entrant =
    """
    {
      "username" : "admin",
      "password" : "password123"
    }
    """
    Given url 'https://restful-booker.herokuapp.com/auth'
    And request entrant
    When method POST
    Then status 200
    And match response.token == '#present'
    And match response.token == '#string'

  @CreateTokenFailed @UnHappyPathss
  Scenario Outline: Creates a new auth token failed due to parameter error
    * def entrant =
    """
    {
      "username" : <username>,
      "password" : <password>
    }
    """
    Given url 'https://restful-booker.herokuapp.com/auth'
    And request entrant
    When method POST
    Then status 400
    And match response == {"reason":"Bad credentials"}
    Examples:
      | username | password      |
      | ''       | 'password123' |
      | 12345    | 'password123' |
      | 'admin'  | ''            |
      | 'admin'  | 1234          |