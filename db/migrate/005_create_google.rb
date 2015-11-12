class CreateGoogle < ActiveRecord::Migration
    def change 
        create_table :googles, force: true do |table|
          table.column :average, :string
          table.column :date,    :string, unique: true
          table.timestamps null: false
        end
    end
end