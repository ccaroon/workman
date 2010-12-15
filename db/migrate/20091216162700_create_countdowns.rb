class CreateCountdowns < ActiveRecord::Migration
    def self.up
        create_table :countdowns do |t|
            t.string :title, :null => false;
            t.datetime :target_date, :null => false;
            t.string :units, :null => false, :default => Countdown::UNIT_DAY;
            t.boolean :on_homepage, :null => false, :default => false;

            t.timestamps
        end
    end

    def self.down
        drop_table :countdowns
    end
end
