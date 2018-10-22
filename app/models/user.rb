class User < ApplicationRecord
  rolify

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :assign_default_role, :create_wallet

  validates :taxvat, uniqueness: true
  validates :first_name, :last_name, presence: true
  validate :taxvat_exist

  has_one :wallet
  has_one :address

  accepts_nested_attributes_for :address

  def name
    has_role?(:drugstore) ? first_name : first_name + ' ' + last_name
  end

  protected

  def assign_default_role
    add_role(:consumer) if roles.blank?
  end

  def create_wallet
    raise has_role?(:drugstore).inspect
    self.wallet = Wallet.create(balance: 0) unless has_role?(:drugstore)
    self.wallet = Wallet.create(balance: 1000) if has_role?(:drugstore)
    save
  end

  def taxvat_exist
    invalid_message = I18n.t('users.registrations.new.error.taxvat_invalid')
    errors.add(:taxvat, invalid_message) unless
      CPF.valid?(taxvat) || CNPJ.valid?(taxvat)
  end
end
