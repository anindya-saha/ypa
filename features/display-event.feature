Feature: Display details about an event
  In order to know everything about a particular event
  As an event enthusiast
  I want to see the details of an event

  Scenario: Go to the details page of an event
    Given some events in the collection
    When I visit the list of events
    And click on "Show"
    Then I see the details page for "Event-1"
