class ChangeTimeType2 < ActiveRecord::Migration[5.1]
  def change
  	change_column :weathers, :time, :string
  end
end
