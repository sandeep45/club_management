class MembersController < AuthenticatedController

  before_action :set_club
  before_action :set_member, only: [:show, :update, :destroy]

  def update_ratings
    # client = SimplyCompeteWrapper.new 'gallian83@hotmail.com', 'bttc', 1017
    client = SimplyCompeteWrapper.new @club.simply_compete_username,
      @club.simply_compete_password, 
      @club.simply_compete_league_id
    
    client.setup_session
    hash = client.download_csv
    hash.each_pair do |k,v|
      Member.where("lower(name) = lower(?)", k).update_all("league_rating=#{v}")
    end
    render json: @club.members
  end

  # GET /members
  def index
    @members = @club.members.all

    render json: @members.to_json(
      :include => {
        :checkins => {
          :include => {
            :member => {
              :only => :id
            }
          }
        }
      }
    )
  end

  def checked_in_today
    @members = @owner.members.joins(:checkins).
      where("checkins.created_at > ? and checkins.created_at < ?",
            Time.current.beginning_of_day, Time.current.end_of_day)

    render json: @members.to_json(
      :include => {
        :checkins => {
          :include => {
            :member => {
              :only => :id
            }
          }
        }
      }
    )
  end

  def checked_in_on_date
    @date = Time.zone.strptime params[:date], '%m-%d-%Y'

    @members = @owner.members.joins(:checkins).
      where("checkins.created_at > ? and checkins.created_at < ?",
            @date.beginning_of_day, @date.end_of_day)

    render json: @members.to_json(
      :include => {
        :checkins => {
          :include => {
            :member => {
              :only => :id
            }
          }
        }
      }
    )
  end

  # GET /members/1
  def show
    render json: @member
  end

  def lookup
    logger.info "will lookup member which matches these params: #{lookup_params[:lookup_params]}"
    @member = @club.members.find_by(lookup_params)

    return render :status => :not_found if @member.blank?

    logger.info "member found: #{@member}"

    render json: @member.to_json(
      :include => {
        :checkins => {
          :include => {
            :member => {
              :only => :id
            }
          }
        }
      }
    )
  end

  def mark_all_part_time
    @club.members.update_all :membership_kind => 'part_time'
  end

  # POST /members
  def create
    @member = @club.members.new(member_params)

    if @member.save
      render json: @member.to_json(
        :include => {
          :club => {
            :include => {
              :members => {
                :only => :id
              }
            },
            :only => :id
          }
        }
      ), status: :created
    else
      render json: @member.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /members/1
  def update
    if @member.update(member_params)
      render json: @member
    else
      puts "got error while updating member"
      puts @member.errors.to_json
      render json: @member.errors, status: :unprocessable_entity
    end
  end

  # DELETE /members/1
  def destroy
    @member.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_club
      @club = @owner.clubs.find(params[:club_id])
      end

    def set_member
      @member = @club.members.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def member_params
      params.require(:member).permit(:name, :email, :club_id, :phone_number,
                                     :qr_code_number, :league_rating,
                                     :usatt_number, :table_number, :membership_kind)
    end

    def lookup_params
      params.require(:lookup_params).permit(:qr_code_number, :email, :phone_number)
    end
end
