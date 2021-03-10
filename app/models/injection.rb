class Injection < ApplicationRecord
  belongs_to :user
  belongs_to :disease

  default_scope { order(:performed_at) }
end
