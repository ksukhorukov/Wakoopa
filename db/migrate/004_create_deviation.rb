class CreateDeviation < ActiveRecord::Migration
    def change 
        create_table :deviations, force: true do |table|
          table.column :result, :string
          table.timestamps null: false
        end
    end
end