class CreateSpreads < ActiveRecord::Migration
    def change 
        create_table :spreads, force: true do |table|
          table.column :site, :string
          table.column :date, :string
          table.column :json, :text
        end
    end
end