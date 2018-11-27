class Bid < ApplicationRecord
  belongs_to :user
  belongs_to :donation
  validate :check_balance

  def status
    if is_cancelled
      return I18n.t('bids.rejected')
    elsif is_accepted
      return I18n.t('bids.accepted')
    end
    I18n.t('bids.waiting')
  end

  def accept
    self.is_accepted = true
    self.donation.finished = true
    self.donation.save
    self.user.wallet.balance = self.user.wallet.balance - self.points
    self.user.wallet.save
    wallet = self.donation.user.wallet
    wallet.balance += self.points
    wallet.save
    save
  end

  private

  def check_balance
    unless user.wallet.get_current_points > points
      errors.add(:points, I18n.t('bids.insufficient_balance'))
    end
  end
end
