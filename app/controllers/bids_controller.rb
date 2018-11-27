class BidsController < ApplicationController
  before_action :set_bid, only: [:show, :edit, :update, :destroy]

  # GET /bids
  # GET /bids.json
  def index
    @bids = Bid.joins(:donation).where("donations.user_id = :user_id OR bids.user_id = :user_id", { user_id: current_user.id })
  end

  def accept
    bid_id = accept_bid_params[:bid_id]
    bid = Bid.find_by_id(bid_id)
    if bid.donation.user_id == current_user.id
      bid.accept
      flash[:success] = I18n.t('bids.accepted_message')
      redirect_to bids_path
    else
      flash[:danger] = I18n.t('bid.cant_accept_message')
      redirect_to bids_path
    end
  end

  # DELETE /bids/1
  # DELETE /bids/1.json
  def destroy
    @bid.destroy
    respond_to do |format|
      format.html { redirect_to bids_url, notice: 'Bid was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bid
      @bid = Bid.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bid_params
      params.require(:bid).permit(:is_accepted, :is_cancelled, :points, :user_id, :donation_id)
    end

    def accept_bid_params
      params.permit(:bid_id)
    end
end
