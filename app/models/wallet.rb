class Wallet < ApplicationRecord

  def user
    User.find_by_id(user_id)
  end

  def get_bid_points
    Bid.where("user_id = :user_id AND is_accepted != true AND is_cancelled != true", { user_id: user_id }).sum("points")
  end

  def get_current_points
    balance - get_bid_points
  end
end
