class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :assign_default_role

  validates :taxvat, uniqueness: true
  validates :first_name, :last_name, presence: true
  validate :taxvat_exist

  def name
    first_name + ' ' + last_name
  end

  def assign_default_role
    add_role(:consumer) if roles.blank?
  end

  protected

  def taxvat_exist
    invalid_message = I18n.t('users.registrations.new.error.taxvat_invalid')
    errors.add(:taxvat, invalid_message) unless
      CPF.valid?(taxvat) || CNPJ.valid?(taxvat)
  end
end
