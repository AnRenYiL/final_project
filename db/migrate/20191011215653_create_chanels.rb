class CreateChanels < ActiveRecord::Migration[6.0]
  def change
    create_table :chanels do |t|
      t.string :title
      t.boolean :is_group

      t.timestamps
    end
  end
end
