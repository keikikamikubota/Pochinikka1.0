class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :phone, presence: true
  
  belongs_to :status, optional: true

  # ransackでの検索を許可する属性を設定するメソッド。4.0.0から必要になった。auth_objectがないとエラーがでる
  def self.ransackable_attributes(auth_object = nil)
    ["admin_note", "created_at", "email", "id", "name", "note", "option1", "option10", "option2", "option3", "option4", "option5", "option6", "option7", "option8", "option9", "phone", "sheet_code", "status_id", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["status"]
  end
end