class ChangeTimeType < ActiveRecord::Migration[5.1]
  def change
  	change_column :weathers, :time, :time
  end
end
