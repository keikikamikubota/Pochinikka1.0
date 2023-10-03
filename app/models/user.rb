class User < ApplicationRecord
  validates :email, presence: true
  validates :phone, presence: true
  
  belongs_to :status, optional: true
end