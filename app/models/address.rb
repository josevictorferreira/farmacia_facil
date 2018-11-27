class Address < ApplicationRecord
  validates :country, :state, :city, :street, :number, :zipcode, presence: true

  def address_formatted
    city + ", " + state + " - " + street + " nº " + number
  end
end
