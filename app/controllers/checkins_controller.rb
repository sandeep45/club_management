class CheckinsController < AuthenticatedController

  before_action :set_member
  before_action :set_checkin, only: [:show, :update, :destroy]

  # GET /checkins
  def index
    if @member.present?
      @checkins = @member.checkins
    else
      @checkins = @owner.checkins
    end

    render json: @checkins
  end

  # GET /checkins/1
  def show
    render json: @checkin
  end

  # POST /checkins
  def create
    @checkin = @member.checkins.of_today.first || @member.checkins.new
    status = @checkin.persisted? ? 208 : 201
    @checkin.updated_at = Time.current

    if @checkin.save
      render json: @checkin.to_json(
        :include => {
          :member => {
            :include => {
              :checkins => {
                :only => :id
              }
            },
            :only => :id
          }
        }
      ), status: status
    else
      render json: @checkin.errors, status: :unprocessable_entity
    end
  end

  # # PATCH/PUT /checkins/1
  # def update
  #   if @checkin.update(params)
  #     render json: @checkin
  #   else
  #     render json: @checkin.errors, status: :unprocessable_entity
  #   end
  # end

  # DELETE /checkins/1
  def destroy
    @checkin.destroy
  end

  private

    def set_member
      if params[:member_id].present?
        @member = @owner.members.find params[:member_id]
      else
        @member = nil
      end

    end

    # Use callbacks to share common setup or constraints between actions.
    def set_checkin
      @checkin = @owner.checkins.find(params[:id])
    end

end
