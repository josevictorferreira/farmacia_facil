class Address < ApplicationRecord
  validates :country, :state, :city, :street, :number, :zipcode, presence: true
end
