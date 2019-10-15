class AddColumnToRequestsTable < ActiveRecord::Migration[6.0]
  def change
    add_column :requests, :sender_id, :bigint, index: true
    add_foreign_key :requests, :users, column: :sender_id
    add_column :requests, :receiver_id, :bigint, index: true
    add_foreign_key :requests, :users, column: :receiver_id
  end
end
