class AddStartDateToVersions < ActiveRecord::Migration
  def change
    add_column :versions, :start_date, :date
  end
end
