class CreateFacebook < ActiveRecord::Migration
    def change 
        create_table :facebooks, force: true do |table|
          table.column :date, :string, unique: true
          table.column :unique_visits, :string 
          table.timestamps null: false
        end
    end
end