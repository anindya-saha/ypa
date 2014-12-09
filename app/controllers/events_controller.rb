class EventsController < ApplicationController

  helper_method :sort_column, :sort_direction

  ############################################################
  # before_filters                                           #
  ############################################################
  before_filter :require_is_admin_true, only: [:new, :create, :edit, :destroy, :reports, :report_view]

  ############################################################
  # require_                                                 #
  ############################################################
  def require_is_admin_true
    unless @is_admin == true
      redirect_to events_path
    end
  end

  ############################################################
  # index                                                    #
  ############################################################
  def index

  # the search "filter" should be in its own function!
	@events = Event.order(sort_column + " " + sort_direction)
	#@events = Event.where(deleted: false)
	
	if params[:name]
		@events = @events.where("name LIKE ?", "%#{params[:name]}%")
	end
	
	if params[:category_id]
		@events = @events.where("category_id = ?", params[:category_id])
	end
	
	if params[:venue]
		@events = @events.where("venue LIKE ?", "%#{params[:venue]}%")
	end
	
	if params[:from_date]
      day = params[:from_date]["written_on(3i)"];
      
	  if day.length != 0
        if day.length < 2
          day = "0" + day
        end

        month = params[:from_date]["written_on(2i)"];
        if month.length < 2
          month = "0" + month
        end
        date_string = params[:from_date]["written_on(1i)"] + "-" + month + "-" + day;
        
		@events = @events.where("from_date >= ?", date_string)
      end
    end
	
	if params[:to_date]
      day = params[:to_date]["written_on(3i)"];
      
	  if day.length != 0
        if day.length < 2
          day = "0" + day
        end

        month = params[:to_date]["written_on(2i)"];
        if month.length < 2
          month = "0" + month
        end
        date_string = params[:to_date]["written_on(1i)"] + "-" + month + "-" + day;
        
		@events = @events.where("to_date <= ?", date_string)
      end
    end
	
	# limit records to 10 per page
    @events = @events.paginate(page: params[:page], per_page: 10)

    respond_to do |format|
      format.html # list.html.erb
      format.json { render json: @events }
    end
  end


  ############################################################
  # report                                                   #
  ############################################################
  def reports

    @past = params[:past]

    if @past == "past"
      @past = params[:past]
      @events =  Event.where(["to_date < ?", Date.today])
      #@events = Event.order(sort_column + " " + sort_direction)
    else
      @events = Event.order(sort_column + " " + sort_direction)
    end
    @events = @events.paginate(page: params[:page], per_page: 10)

    respond_to do |format|
      format.html # reports.html.erb
    end
  end

  ############################################################
  # report_view                                              #
  ############################################################
  def report_view
    event_id = params[:id]
    @event =  Event.find(event_id)
    @count_rsvp =  UserEvent.where(['event_id = ? AND rsvp = ?', event_id, true]).count
    @count_check_in = UserEvent.where(['event_id = ? AND signin = ?', event_id, true]).count

    @users = User.select('users.first_name, users.last_name, users.email, users.phone, user_events.signin, user_events.rsvp').where(['user_events.event_id = ?', event_id]).joins(:user_events)


    respond_to do |format|
      format.html # report_view.html.erb
      format.json { render json: @events }
    end

  end



  ############################################################
  # user event's page, display events that user has rsvp     #
  # or has checked-in to                                     #
  ############################################################

  def user

    @events =  Event.joins(:user_events).where(['user_events.user_id = ? AND (user_events.rsvp = ? OR user_events.signin = ?) AND events.deleted = ? AND user_events.deleted = ?', @user_id, true, true, false, false]).paginate(page: params[:page], per_page: 10).order(sort_column + " " + sort_direction)

    render "events/user_event"
  end

  ############################################################
  # show                                                     #
  ############################################################
   def show

    @event =  Event.find(params[:id])

    @has_already_rsvp = has_user_rsvp?(params[:id])
    @already_checked_in = has_user_checked_in?(params[:id])
    @can_check_in = user_can_check_in?(params[:id])
    @user_can_rsvp = user_can_rsvp?(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  ############################################################
  # has_user_rsvp?                                           #
  ############################################################
  def has_user_rsvp?(event_id)
    db_row = UserEvent.select("rsvp").where(['user_events.event_id = ? AND user_events.user_id = ? AND user_events.deleted = ?', params[:id], @user_id, false]).first
    if !db_row.nil? and db_row.rsvp == true
      true
    else
      false
    end
  end

  ############################################################
  # user_can_rsvp?                                           #
  ############################################################
  def user_can_rsvp?(event_id)
    event = Event.find(event_id)
    start_time = Time.local(event.from_date.strftime('%Y'), event.from_date.strftime('%m'), event.from_date.strftime('%d'), event.from_time.strftime('%H'), event.from_time.strftime('%M'))
    if start_time >= Time.now
      true
    else
      false
    end
  end

  ############################################################
  # can_user_check_in?                                       #
  ############################################################
  def user_can_check_in?(event_id)

    event =  Event.find(event_id)
    start_time = Time.local(event.from_date.strftime('%Y'), event.from_date.strftime('%m'), event.from_date.strftime('%d'), event.from_time.strftime('%H'), event.from_time.strftime('%M'))
    end_time = Time.local(event.to_date.strftime('%Y'), event.to_date.strftime('%m'), event.to_date.strftime('%d'), event.to_time.strftime('%H'), event.to_time.strftime('%M'))
    min_minutes_before = event.min_before_start
    max_minutes_after = event.max_before_end

    # db_row = UserEvent.select("signin").where(['user_events.event_id = ? AND user_events.user_id = ? AND user_events.deleted = ?', params[:id], @user_id, false]).first

    if (TimeDifference.between(start_time, Time.now).in_minutes) <= min_minutes_before or
       (TimeDifference.between(Time.now, end_time).in_minutes) <= max_minutes_after or
       (start_time - Time.now) * (Time.now - end_time) >= 0
        db_row = UserEvent.select("signin").where(['user_events.event_id = ? AND user_events.user_id = ? AND user_events.deleted = ?', event_id, @user_id, false]).first
      if !db_row.nil? and db_row.signin == true
        false
      else
        true
      end
    else
      false
    end
  end


  ############################################################
  # process click on check_in button on event show           #
  ############################################################
  def check_in

    event_id = params[:id]
    if user_can_check_in?(event_id)
      row = UserEvent.where(['user_events.event_id = ? AND user_events.user_id = ? AND user_events.deleted = ?', event_id, @user_id, false]).first

      if row
        row.signin = true
      else
        row = new_user_event_obj(event_id)
        row.signin = true
      end

      row.save!
      flash[:notice] = "You have successfully checked in to this event."

    else
      flash[:notice] = "You cannot checkin to this event"
    end

    redirect_to '/events/' + params[:id]
  end

  ############################################################
  # has_user_checkedn?                                       #
  ############################################################

  def has_user_checked_in?(event_id)
    row = UserEvent.where(['user_events.event_id = ? AND user_events.user_id = ? AND user_events.deleted = ?', event_id, @user_id, false]).first
    if !row.nil? and row.signin == true
      true
    else
      false
    end
  end

  ############################################################
  # process click on rsvp/de-rsvp button on event show       #
  ############################################################
  def rsvp

    event_id = params[:id]

    if user_can_rsvp?(event_id)

      row = UserEvent.where(['user_events.event_id = ? AND user_events.user_id = ? AND user_events.deleted = ?', event_id, @user_id, false]).first

      if row
        row.rsvp = !row.rsvp
      else
        row = new_user_event_obj(event_id)
        row.rsvp = true
      end

      row.save!

     if row.rsvp== true
       flash[:notice] = "You have successfully RSVP'D to this event."
     else
       flash[:notice] = "You have successfully UN-RSVP'D to this event."
     end

    else
      flash[:alert] = "You cannot create/edit a rsvp to/of a past event."
    end

    redirect_to '/events/' + params[:id]

  end

  def new_user_event_obj(event_id)
    row = UserEvent.new
    row.event_id = event_id
    row.user_id = @user_id
    return row
  end


  ############################################################
  # new                                                      #
  ############################################################
  # GET /events/new
  # GET /events/new.json
  def new
    @event = Event.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  ############################################################
  # edit                                                     #
  ############################################################
  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.json
  def create

    @event = Event.new(params[:event])

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  ############################################################
  # update                                                   #
  ############################################################
  # PUT /events/1
  # PUT /events/1.json
  def update

    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  ############################################################
  # destroy                                                  #
  ############################################################
  # DELETE /events/1
  # DELETE /events/1.json
  def destroy

    # assign from session variable
    @is_admin = true

    @event = Event.find(params[:id])
    #@event.update_attribute(:deleted, true)
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end
  
  private
  
  def sort_column
    Event.column_names.include?(params[:sort]) ? params[:sort] : "from_date"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
  
end
