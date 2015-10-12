json.array!(@emails) do |email|
  json.extract! email, :id, :company_id, :product_id, :recipient, :sender, :from, :body, :body_plain, :body_html, :created_at, :updated_at, :subject
  json.url email_url(email, format: :json)
end
