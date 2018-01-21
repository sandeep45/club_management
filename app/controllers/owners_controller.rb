class OwnersController < AuthenticatedController

  # before_action :set_owner, only: [:show, :update, :destroy]

  # GET /owners
  # def index
  #   @owners = Owner.all
  #
  #   render json: @owners
  # end

  # GET /owners/1
  # # Note not returned upon login. as the auth tool returns its thing.
  def show
    render json: @owner.to_json(
      :include => {
        :clubs => {
          :only => :id
        }
      }
    )
  end

  # POST /owners
  # def create
  #   @owner = Owner.new(owner_params)
  #
  #   if @owner.save
  #     render json: @owner, status: :created
  #   else
  #     render json: @owner.errors, status: :unprocessable_entity
  #   end
  # end

  # PATCH/PUT /owners/1
  def update
    if @owner.update(owner_params)
      render json: @owner
    else
      render json: @owner.errors, status: :unprocessable_entity
    end
  end

  # DELETE /owners/1
  def destroy
    @owner.destroy
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    # def set_owner
    #   @owner = Owner.find(params[:id])
    # end

    # Only allow a trusted parameter "white list" through.
    def owner_params
      params.require(:owner).permit(:email)
    end
end
