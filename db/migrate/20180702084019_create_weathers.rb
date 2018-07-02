class CreateWeathers < ActiveRecord::Migration[5.1]
  def change
    create_table :weathers do |t|
      t.string :location_name
      t.string :element
      t.datetime :time
      t.string :parameter
      t.string :parameter_value

      t.timestamps
    end
  end
end
