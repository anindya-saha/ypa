require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  setup do
    @event = events(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:events)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create event" do
    assert_difference('Event.count') do
      post :create, event: { category: @event.category, created_by: @event.created_by, deleted: @event.deleted, description: @event.description, event_id: @event.event_id, from_date: @event.from_date, from_time: @event.from_time, max_before_end: @event.max_before_end, min_before_start: @event.min_before_start, name: @event.name, to_date: @event.to_date, to_time: @event.to_time, updated_by: @event.updated_by, venue: @event.venue }
    end

    assert_redirected_to event_path(assigns(:event))
  end

  test "should show event" do
    get :show, id: @event
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @event
    assert_response :success
  end

  test "should update event" do
    put :update, id: @event, event: { category: @event.category, created_by: @event.created_by, deleted: @event.deleted, description: @event.description, event_id: @event.event_id, from_date: @event.from_date, from_time: @event.from_time, max_before_end: @event.max_before_end, min_before_start: @event.min_before_start, name: @event.name, to_date: @event.to_date, to_time: @event.to_time, updated_by: @event.updated_by, venue: @event.venue }
    assert_redirected_to event_path(assigns(:event))
  end

  test "should destroy event" do
    assert_difference('Event.count', -1) do
      delete :destroy, id: @event
    end

    assert_redirected_to events_path
  end
end
