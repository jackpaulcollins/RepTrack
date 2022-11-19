json.extract! report, :id, :user_id, :account_id, :points, :rep_type, :rep_count, :created_at, :updated_at
json.url report_url(report, format: :json)
