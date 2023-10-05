class Sheet < ApplicationRecord
  has_many :import_details
  accepts_nested_attributes_for :import_details, allow_destroy: true
end
