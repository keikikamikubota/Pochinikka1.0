module ApplicationHelper
  def bootstrap_class_for_flash(type)
    base_class = "alert"
    specific_class = case type
                     when "notice" then "info"
                     when "success" then "success"
                     when "error", "alert" then "danger"
                     when "warning" then "warning"
                     else type.to_s
                     end
    "#{base_class}-#{specific_class}"
  end
end
