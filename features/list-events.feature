Feature: Display the list of events
  In order to know which events the collection contains
  As an event manager
  I want to see a list of all events

  Scenario: Display the list of all events in the collection
    Given some events in the collection
    When I visit the list of events
    Then I see all events

  Scenario: Filter the list
    Given some events in the collection
    When I visit the list of events
    And I search for "Event-1"
    Then I only see names matching the search term
    When I remove the filter
    Then I see all events again

  Scenario: Sort the list
    Given some events in the collection
    When I visit the list of events
    And sort by "Event"
    Then I see "Event-1" listed first
    And "Event-2" listed second
    And "Event-3" listed third
