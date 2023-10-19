class Sheet < ApplicationRecord
  has_many :import_details
  accepts_nested_attributes_for :import_details, allow_destroy: true

  validates :title, presence: true
  validates :spreadsheet_id, presence: true
  validates :range, presence: true

end
