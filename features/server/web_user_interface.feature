Feature: Mirage's home page allows you to see what response are currently being hosted.
  From this page you can:
  - Peek at a responses content
  - Track the response to see if a request has been made to it

#TODO tests needed for displaying pattern and delay values and http method

  Background: There are already a couple of responses hosted on he Mirage server
    Given I send PUT to 'http://localhost:7001/mirage/templates/greeting' with body 'hello' and headers:
      | X-mirage-default | true |
      | X-mirage-method  | POST |
    And I send PUT to 'http://localhost:7001/mirage/templates/leaving' with body 'goodbye'

  Scenario: Using the home page to see what response are being hosted
    Given I goto 'http://localhost:7001/mirage'
    Then I should see 'greeting/*'
    Then I should see 'leaving'

  Scenario: Using the home page to peek at a response
    Given I goto 'http://localhost:7001/mirage'
    When  I click 'peek_response_1'
    Then I should see 'hello'

  Scenario: Using the home page to track if a request has been made
    Given I send POST to 'http://localhost:7001/mirage/responses/greeting' with request entity
    """
    Yo!
    """
    Given I goto 'http://localhost:7001/mirage'
    When  I click 'track_response_1'
    Then I should see 'Yo!'