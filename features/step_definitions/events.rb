#encoding: utf-8

Given /^some events in the collection$/ do
  upload_fixtures backend_url('events'), $fixtures
end

When /^I visit the list of events$/ do
  visit ui_url '/index.html'
end

When /^I search for "(.*?)"$/ do |search_term|
  fill_in('filter', :with => search_term)
  @matching_names = ['Event-1']
  @not_matching_names = ['Event-2', 'Event-3']
end

When /^I remove the filter$/ do
  fill_in('filter', :with => ' ')
  @matching_names = @not_matching_names = nil
end

When /^(?:I )?sort by "(.*?)"$/ do |sort_criterion|
  click_on sort_criterion
end

When /^select "(.*?)" from the menu$/ do |option|
  click_link option
end

When /^click on "(.*?)"$/ do |link|
  click_link link
end

When /^click the link to add a new event$/ do
  click_link 'New Event'
end

When /^I change in a new event$/ do
  fill_in('name', :with => 'NewEvent-1')
  fill_in('desc', :with => 'Test Event Cucumber')
  fill_in('from_date', :with => '2014-12-10')
  fill_in('to_date', :with => '2014-12-11')
end

When /^save it$/ do
  click_button 'Save'
end

Then /^I see all events(?: again)?$/ do
  page.should have_content 'Event-1'
  page.should have_content 'Event-2'
  page.should have_content 'Event-3'
end

Then /^I only see titles matching the search term$/ do
  @matching_names.each do |name|
    page.should have_content name
  end

  @not_matching_names.each do |name|
    page.should have_no_content name
  end
end

Then /^(?:I see )?"(.*?)" listed (first|second|third)$/ do |name, position|
  row = {'first' => '1', 'second' => '2', 'third' => '3'}[position]
  within_table 'list_events' do
    within(:xpath, ".//tbody/tr[#{row}]") do
      page.should have_content name
    end
  end
end

Then /^I see the form for adding a new event$/ do
  page.find('h1').should have_content 'Create Event'
end

Then /^I see the new event in the list of events$/ do
  visit ui_url '/index.html'
  page.should have_content('NewEvent-1')
end

Then /^I see the details page for "(.*?)"$/ do |event_name|
  page.find('h1').should(have_content('NewEvent-1'))
end
