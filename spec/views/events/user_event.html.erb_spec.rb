require 'spec_helper'
require 'rails_helper'
require 'rspec/active_model/mocks'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../../../config/environment", __FILE__)
describe "events/user_event" do

  it 'should render the list of events for the user' do

    #assign(:event, [fake_results = mock_model("Social")])
    fake_result = [mock_model("S")]
    render_template("user_event")

    #rendered.should contain("Social")
    expect(rendered).to match /S/

  end
end