class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :taxvat, uniqueness: true
  validates :first_name, :last_name, presence: true
  validate :taxvat_exist

  def name
    first_name + ' ' + last_name
  end

  protected

  def taxvat_exist
    errors.add(:taxvat, I18n.t('users.registrations.new.error.taxvat_invalid')) unless
      CPF.valid?(taxvat) || CNPJ.valid?(taxvat)
  end
end
