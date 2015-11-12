class CreateVisits < ActiveRecord::Migration
    def change 
        create_table :visits, force: true do |table|
          table.column :site, :string
          table.column :date, :string
          table.column :json, :text
        end
    end
end