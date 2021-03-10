class User < ApplicationRecord
  validates :name, presence: true
  validates :birthdate, presence: true
end
