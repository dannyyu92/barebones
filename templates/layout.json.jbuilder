json.status @status

if @errors.present? || @error_msg.present?
  json.errors do
    if @error_msg.present?
      json.message @error_msg # Error message to display to the user
    end
    if @errors.present?
      json.errors @errors do |error|
        json.message error
      end
    end
  end
else
  # Don't show error block if there aren't any errors
end

if @data.present?
  json.data @data
else
  json.data JSON.parse(yield)
end