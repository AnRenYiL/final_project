class Request < ApplicationRecord
    belongs_to :sender, class_name: :user, foreign_key: :sender_id
    belongs_to :receiver, class_name: :user, foreign_key: :receiver_id

end
