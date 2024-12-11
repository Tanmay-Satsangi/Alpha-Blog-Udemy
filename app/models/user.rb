class User < ApplicationRecord
    # Using dependent: :destroy, if a user is deleted, their associated articles will also be destroyed.
    has_many :articles, dependent: :destroy

    before_save { self.email = email.downcase }

    validates :username, presence: true, 
                        uniqueness: { case_sensitive: false }, # new line start after comma.
                        length: { minimum: 3, maximum: 25 }

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

    validates :email, presence: true, 
                        uniqueness: { case_sensitive: false }, 
                        length: { maximum: 105 }, 
                        format: { with: VALID_EMAIL_REGEX }

    has_secure_password
end
