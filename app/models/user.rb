class User < ApplicationRecord
    has_secure_password

    # relationships
    has_many :chanel_users
    # has_many :friend_chanels, ->{ where(is_group: false)} , through: :chanel_users, source: :chanel
    has_many :group_chanels, ->{ where(is_group: true)} , through: :chanel_users, source: :chanel
    has_many :channels, through: :chanel_users, source: :chanel

    # has_many :friends, ->{ where(is_group: false)}, through: :chanel_users, source: :user
    # has_many :friends, through: :friend_chanels, source: :chanel_users
    # has_many :friends, :class_name => 'User', :finder_sql => '
    #     SELECT users.* FROM users INNER JOIN chanel_users ON chanel_users.user_id = users.id 
    #     WHERE chanel_users.chanel_id in 
    #     (SELECT chanels.id
    #     FROM chanels INNER JOIN chanel_users ON chanel_users.chanel_id = chanels.id 
    #     WHERE chanel_users.user_id = #{id} AND chanels.is_group = false)'
    has_many :received_requests, class_name: "Request", foreign_key: :receiver_id
    has_many :sent_requests, class_name: "Request", foreign_key: :sender_id

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
