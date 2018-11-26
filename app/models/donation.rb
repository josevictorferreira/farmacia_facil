class Donation < ApplicationRecord
  def medicine_name
    Medicine.find_by_id(medicine_id).name
  end
end
