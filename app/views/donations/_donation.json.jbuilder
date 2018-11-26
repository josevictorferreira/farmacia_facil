json.extract! donation, :id, :description, :quantity, :shelf_life, :has_packing, :created_at, :updated_at
json.url donation_url(donation, format: :json)
