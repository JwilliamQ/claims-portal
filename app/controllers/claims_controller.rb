class ClaimsController < ApplicationController
  def index

    @approved_count = Claim.where(claim_status: 'approved', claim_username: current_user&.name).count
    @declined_count = Claim.where(claim_status: 'declined', claim_username: current_user&.name).count
    @under_review_count = Claim.where(claim_status: 'under_review', claim_username: current_user&.name).count
    if params[:status].present?
      @claims = Claim.where(claim_status: params[:status], claim_username: current_user&.name)
    else
      @claims = Claim.where(claim_username: current_user&.name)
    end
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
      redirect_to new_claim_path
    else
      flash[:notice] = "Claim creation failed"
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @claim = Claim.find(params[:id])
  end

  def approve
    @claim = Claim.find(params[:id])
    @claim.update(claim_status: 'approved')
    redirect_to claims_path(status: 'under_review')
  end

  def decline
    @claim = Claim.find(params[:id])
    @claim.update(claim_status: 'declined')
    redirect_to claims_path(status: 'under_review')
  end

  private

  def claim_params
    params.require(:claim).permit(:claim_username, :created_by, :claim_data, :customer_name, :claim_status)
  end
end
