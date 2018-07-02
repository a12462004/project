class CreateStates < ActiveRecord::Migration[5.1]
  def change
    create_table :states do |t|
      t.integer :num
      t.string :img

      t.timestamps
    end
  end
end
