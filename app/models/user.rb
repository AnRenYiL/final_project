class User < ApplicationRecord
    has_secure_password

    # validations
    validates(:user_name, presence: true, uniqueness: true)
    validates(:email, presence: true, uniqueness: true)

    # before create
    before_create :set_default_picture_url

    

    private

    def set_default_picture_url
        self.picture_url ||= "logo.png"
    end
    
end
