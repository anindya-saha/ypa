require 'rubygems'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'C:\Users\mehnaz\Desktop\ypa-master bibek\ypa-master/app/models/event'
require 'C:\Users\mehnaz\Desktop\ypa-master bibek\ypa-master/app/controllers/events_controller'
require 'spec_helper'

describe EventsController, type: :controller do
  describe "GET EventsController#index" do
    it "assigns @events" do
      fromday = Hash.new();
      fromday["written_on(1i)"] = "2014"
      fromday["written_on(2i)"] = "12"
      fromday["written_on(3i)"] = "09"

      today = Hash.new();
      today["written_on(1i)"] = "2014"
      today["written_on(2i)"] = "12"
      today["written_on(3i)"] = "10"
      @event = get :index
      if(response.should be_success)
        puts 'found match'
      else
        puts 'not found'


    end
    end
  end
  end






