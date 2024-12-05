class Article < ApplicationRecord
  belongs_to :user
  
  # In the code below, the user_id might be null. However, in the preceding(above) code, the user_id must be present and cannot be null.  # belongs_to :user, optional: true

  validates :title, presence: true, length: { minimum: 6, maximum: 100}
  validates :description, presence: true, length: { minimum: 10, maximum: 300}
end
