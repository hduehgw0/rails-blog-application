class Post < ApplicationRecord
  belongs_to :user

  # Validations
  validates :title, presence: true, length: { maximum: 140 }
  validates :content, presence: true

  # Scopes
  default_scope -> { order(created_at: :desc) }
end
