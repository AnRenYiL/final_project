class AddLastCheckToChanelUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :chanel_users, :last_check, :datetime
  end
end
