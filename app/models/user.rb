class User < ApplicationRecord
  validates :email, presence: true
  validates :phone, presence: true
  
  has_many :statuses, dependent: :destroy
end
