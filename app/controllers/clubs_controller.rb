class ClubsController < AuthenticatedController

  before_action :set_club, only: [:show, :update, :destroy,
                                  :assign_tables_straight,
                                  :assign_tables_every_other,
                                  :assign_tables_random]

  before_action :pre_assignment, only: [:assign_tables_every_other, :assign_tables_straight,
                                        :assign_tables_random]

  def assign_tables_straight
    member_ids = @members.pluck :id
    member_ids.each_slice(@people_per_table).each_with_index do |slice, batch_index|
      Member.where(:id => slice).update_all :table_number => batch_index+1
    end

    render json: @club.members.which_are_checked_in
  end

  def assign_tables_every_other
    table_number = 1
    @members.each do |member|
      member.update :table_number => table_number
      table_number = table_number + 1
      table_number = 1 if table_number > @number_of_tables
    end

    render json: @club.members.which_are_checked_in
  end

  def assign_tables_random
    table_number = 1
    @members = @members.shuffle
    @members.each do |member|
      member.update :table_number => table_number
      table_number = table_number + 1
      table_number = 1 if table_number > @number_of_tables
    end

    render json: @club.members.which_are_checked_in
  end

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
      params.require(:club).permit(:name, :owner_id, :keyword,
       :simply_compete_username, :simply_compete_password,
       :simply_compete_league_id, :default_amount_to_collect)
    end

    def pre_assignment
      @number_of_tables = params[:number_of_tables].to_i
      @people_per_table = params[:people_per_table].to_i
      @total_players_count = @number_of_tables * @people_per_table

      @club.members.which_are_checked_in.update_all :table_number => 0
      @members = @club.members.which_are_checked_in.
        order("members.league_rating DESC").limit(@total_players_count)
    end
end
