class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def getEvents(query)
    res = Excon.get(query)
    MultiJson.load(res.body)
  end

  def FBevent(fid)
    getEvents(fid)
  end

  def FBsave
    fbevents = getEvents('https://graph.facebook.com/v2.2/151742221561550/events?limit=22&access_token=')
    fbevents["data"].each do |item|
      fid = item["id"]
      fbevent = FBevent("https://graph.facebook.com/v2.2/151742221561550/events/#{fid}?access_token=")
      event = Event.where(fb_event_id: fid).first_or_initialize
      event.name = item["name"]
      event.start_time =DateTime.parse item["start_time"]
      event.end_time = event.start_time + 2.hours
      event.created_at = event.start_time
      event.location = item["location"]
      event.description = fbevent["description"]
      event.latitude = fbevent["venue"]["latitude"]
      event.longitude = fbevent["venue"]["longitude"]
      event.save!
    end
  end

  def meetup
    params = { group_id: '18227415',
    order: 'time',
    limited_events: 'False',
    group_urlname: 'rorlab',
    desc: 'false',
    offset: '0',
    'photo-host'=> 'public',
    status: 'upcoming',
    format: 'json',
    page: '1',
    sig_id: '183104437',
    sig: '8582943c0971b9d5502a466ae1a5e98c36ca47be',
    sign: 'true'}
    meetup_api = MeetupApi.new
    meetupevent = meetup_api.method_request('events',params)

  end

  def upcoming
    meetupevent = meetup()
    meetupevent["results"].each do |item|
    fid = item["id"]
    event = Event.where(fb_event_id: fid).first_or_initialize
    event.name = item["name"]
    event.start_time = DateTime.strptime(item["time"].to_s,"%Q")
    event.end_time = DateTime.strptime((item["time"]+item["duration"]).to_s,"%Q")
    event.location = item["venue"]["name"]
    event.event_url = item["event_url"]
    event.description = item["description"]
    event.latitude = item["venue"]["lat"]
    event.longitude = item["venue"]["lon"]
    event.save!
    end
  end

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
    @events = @events.paginate(page: params[:page], per_page: 10)
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])

  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit

  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }

      else
        format.html { render :new }

      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }

      else
        format.html { render :edit }

      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }

    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:access_token, :name, :start_time, :end_time, :location, :fb_event_id, :description, :latitude, :latitude, :longitude, :longitude, :updated_time, :material, :modifiable, :event_url)
    end
end
