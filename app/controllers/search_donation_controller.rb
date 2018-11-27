class SearchDonationController < ApplicationController
  before_action :must_be_drugstore

  def index
    @donations = Donation.where.not(finished: true)
  end

  def place_offer
    new_bid = Bid.new({
      points: place_offer_params[:points],
      donation_id: place_offer_params[:donation_id],
      is_accepted: false,
      is_cancelled: false,
      user_id: current_user.id
    })
    if new_bid.save
      redirect_to bids_path
    else
      flash[:danger] = new_bid.errors.full_messages.first
      redirect_to search_donation_index_path
    end
  end

  private

  def place_offer_params
    params.permit(:points, :donation_id)
  end

  def must_be_drugstore
    unless current_user && authorized_for_roles(:admin, :drugstore)
      raise CanCan::AccessDenied
    end
  end
end
