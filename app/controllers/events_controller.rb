class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    #@events = Event.all
    @admin_events = AdminEvent.all
  end

  # GET /events/1
  # GET /events/1.json
  def show

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
      check = Event.find_by(eventid: @event.eventid, uuid: @event.uuid)
      count = Event.joins(:user).where(eventid: @event.eventid).count
      @adminEvent = AdminEvent.find(@event.eventid)
      if check == nil and User.find_by(uuid: @event.uuid) and count < @adminEvent.count
        if@event.save
          format.html { redirect_to event_path(@adminEvent), notice: '登録完了しました' }
          #format.json { render :show, status: :created, location: @event }
        else
          format.html { redirect_to event_path(@event.eventid),:flash => {:danger=>"データベースエラー"}}
          #format.json { render json: @event.errors, status: :unprocessable_entity }
        end
      else
        message="データベースエラー"
        if check != nil
          message ="イベントに参加しています"
        elsif count >= @adminEvent.count
          message ="イベントの参加人数をオーバーしています"
        else
          message ="UUIDが登録されていません"
        end
        format.html { redirect_to event_path(@event.eventid),:flash => {:danger=>message}}
        #format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        #format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        #format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.new
      @event.eventid = params[:id]
      @adminEvent = AdminEvent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:eventid, :uuid, :flag)
    end
end
