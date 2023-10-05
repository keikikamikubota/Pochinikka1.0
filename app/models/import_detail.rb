class ImportDetail < ApplicationRecord
  belongs_to :sheet

  enum selected_title:{ customer_name: 0,
                        email: 1,
                        phone: 2,
                        status_id: 3,
                        note: 4,
                        admin_note: 5,
                        sheet_code: 6,
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