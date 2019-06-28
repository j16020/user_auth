class AdminEventsController < ApplicationController

  before_action :logged_in_user, only: [:index,:show, :edit, :update, :destroy,:download]
  before_action :set_admin_event, only: [:show, :edit, :update, :destroy]


  # GET /admin_events
  # GET /admin_events.json
  def index
    @admin_events = AdminEvent.all
  end

  # GET /admin_events/1
  # GET /admin_events/1.json
  def show
  end

  # GET /admin_events/new
  def new
    @admin_event = AdminEvent.new
  end

  # GET /admin_events/1/edit
  def edit
  end

  # POST /admin_events
  # POST /admin_events.json
  def create
    @admin_event = AdminEvent.new(admin_event_params)
    respond_to do |format|
      if @admin_event.save
        format.html { redirect_to @admin_event, success: '作成されました' }
        #format.json { render :show, status: :created, location: @admin_event }
      else
        format.html { render :new }
        #format.json { render json: @admin_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin_events/1
  # PATCH/PUT /admin_events/1.json
  def update
    respond_to do |format|
      if @admin_event.update(admin_event_params)
        format.html { redirect_to @admin_event, notice: '更新しました' }
        #format.json { render :show, status: :ok, location: @admin_event }
      else
        format.html { render :edit }
        #format.json { render json: @admin_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_events/1
  # DELETE /admin_events/1.json
  def destroy
    @admin_event.destroy
    respond_to do |format|
      format.html { redirect_to admin_events_url, notice: '削除されました' }
      #format.json { head :no_content }
    end
  end

  #file download
  def download
    @userList = Event.joins(:user).where(eventid: params[:id]).select(:mcid)
    @data=""
    @userList.each do |user|
      if user.mcid?
        @data = @data+user.mcid+"\n"
      end
    end
    send_data(@data, :filename => 'user.txt')
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_event
      @joinUser = Event.joins(:user).where(eventid: params[:id]).select(:id,:mail,:mcid,:uuid)
      @userCount = Event.joins(:user).where(eventid: params[:id]).count
      @admin_event = AdminEvent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_event_params
      params.require(:admin_event).permit(:title,:content,:image,:count)
    end
    # ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください"
        redirect_to login_url
      end
    end

end
