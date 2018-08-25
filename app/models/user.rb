class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :taxvat, uniqueness: true
  validate :taxvat_exist

  protected

  def taxvat_exist
    errors.add(:taxvat, 'Invalid identification.') unless
      CPF.valid?(taxvat) || CNPJ.valid?(taxvat)
  end
end
