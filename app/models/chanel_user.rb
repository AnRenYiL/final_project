class ChanelUser < ApplicationRecord
  belongs_to :user
  belongs_to :chanel
  validates :chanel_id, uniqueness: { scope: :user_id, message: "already has that user"}
end
