class CreateRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :requests do |t|
      t.boolean :is_accepted

      t.timestamps
    end
  end
end
