class Donation < ApplicationRecord
  has_many :bids

  def bid_status(user)
    bid = bids.where('user_id = :user_id', { user_id: user.id }).first
    if bid.nil?
      return false
    end
    bid.status
  end

  def medicine_name
    Medicine.find_by_id(medicine_id).name
  end

  def user
    User.find_by_id(user_id)
  end

  def donator_name
    User.find_by_id(user_id).name
  end
end
