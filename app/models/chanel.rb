class Chanel < ApplicationRecord
    has_many :messages
    has_many :chanel_users
    has_many :members, through: :chanel_users, source: :user
end
