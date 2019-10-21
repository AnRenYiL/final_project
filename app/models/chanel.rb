class Chanel < ApplicationRecord
    has_many :messages
    has_many :chanel_users
end
