class ClaimsController < ApplicationController
  def index
    @claims = Claim.where(claim_username: current_user&.name)
  end

  def new
    @claim = Claim.new
    @claim_users = User.where(user_type: 'claims').pluck(:name) # Fetch users with user_type 'claims'
  end

  def create
    @claim = Claim.new(claim_params)

    # Set default values
    @claim.claim_status = 'under_review' unless @claim.claim_status.present?
    @claim.created_by = current_user.name if current_user.present?

    if @claim.save
      flash[:notice] = "Claim created successfully"
      redirect_to claims_path
    else
      flash[:notice] = "Claim creation failed"
      render :new, status: :unprocessable_entity
    end
  end

  private

  def claim_params
    params.require(:claim).permit(:claim_username, :created_by, :claim_data, :customer_name, :claim_status)
  end
end
