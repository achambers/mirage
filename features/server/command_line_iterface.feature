@command_line
Feature: Mirage is started from the command line.
  Mirage logs to mirage.log at the path where Mirage is started from


  Background: Mirage usage
    Given usage information:
      | Usage: mirage start\|stop [options] |
      | -p, --port PORT                     |
      | -d, --defaults DIR                  |


  Scenario: Starting with help option
    Given I run 'mirage --help'
    Then the usage information should be displayed


  Scenario: Starting with an invalid option
    Given I run 'mirage start --invalid-option'
    Then the usage information should be displayed


  Scenario: Starting mirage
    Given Mirage is not running
    When I run 'mirage start'
    Then mirage should be running on 'http://localhost:7001/mirage'
    And 'mirage.log' should exist


  Scenario: Stopping Mirage
    Given Mirage is running
    When I run 'mirage stop'
    Then Connection should be refused to 'http://localhost:7001/mirage'


  Scenario: Starting Mirage on a custom port
    Given Mirage is not running
    When I run 'mirage start -p 9001'
    Then mirage should be running on 'http://localhost:9001/mirage'

  Scenario: Starting Mirage when it is already running
    Given Mirage is running
    When I run 'mirage start -p 9001'
    Then I should see 'Mirage is already running' on the command line
    Then Connection should be refused to 'http://localhost:9001/mirage' 