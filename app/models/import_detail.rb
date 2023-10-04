class ImportDetail < ApplicationRecord
  belongs_to :sheet

  enum selected_title:{ 名前: 0,
                        メールアドレス: 1,
                        電話番号: 2,
                        ステータス:3,
                        備考: 4,
                        管理者メモ: 5,
                        シート番号: 6,
                        option1: 7,
                        option2: 8,
                        option3: 9,
                        option4: 10,
                        option5: 11,
                        option6: 12,
                        option7: 13,
                        option8: 14,
                        option9: 15,
                        option10: 16
  }
end
