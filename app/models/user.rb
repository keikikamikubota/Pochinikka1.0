class User < ApplicationRecord
  validates :email, presence:  true
  validates :phone, presence: true
end
