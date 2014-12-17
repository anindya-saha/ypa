Feature: Add an event to the collection
  In order to have the collection up to date when I buy new events
  As an event enthusiast
  I want to add new events

  Scenario: Add a new event to the collection via menu
    When I visit the list of events
    And select "Create Event" from the menu
    Then I see the form for adding a new event
    When I change in a new event
    And save it
    Then I see the new event in the list of events

  Scenario: Add a new event to the collection via button on list page
    When I visit the list of events
    And click the link to add a new event
    Then I see the form for adding a new event
    When I change in a new event
    And save it
    Then I see the new event in the list of events
