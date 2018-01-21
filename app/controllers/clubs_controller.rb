class ClubsController < AuthenticatedController

  before_action :set_club, only: [:show, :update, :destroy]

  # GET /clubs
  def index
    render json: @owner.clubs.to_json(
      :include => {
        :members => {
          :only => :id
        }
      }
    )
  end

  # GET /clubs/1
  def show
    render json: @club
  end

  # POST /clubs
  def create
    @club = @owner.clubs.new(club_params)

    if @club.save
      render json: @club, status: :created
    else
      render json: @club.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /clubs/1
  def update
    if @club.update(club_params)
      render json: @club
    else
      render json: @club.errors, status: :unprocessable_entity
    end
  end

  # DELETE /clubs/1
  def destroy
    @club.destroy
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_club
      @club = @owner.clubs.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def club_params
      params.require(:club).permit(:name, :owner_id)
    end
end
