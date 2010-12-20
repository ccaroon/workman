class CreateNotesTable < ActiveRecord::Migration
    def self.up
        create_table :notes do |t|
            t.column :title,        :string,   :null => false;
            t.column :created_on,   :datetime, :null => false;
            t.column :updated_on,   :datetime, :null => false;
            t.column :body,         :text,     :null => false;
        end
    end

    def self.down
        drop_table :notes;
    end
end
