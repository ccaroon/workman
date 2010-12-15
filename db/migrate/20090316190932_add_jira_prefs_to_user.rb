################################################################################
# $Id: 20090316190932_add_jira_prefs_to_user.rb 1444 2009-03-16 20:04:10Z ccaroon $
################################################################################
class AddJiraPrefsToUser < ActiveRecord::Migration
    def self.up
        add_column :users, :jira_host, :string, :null => true, :default => nil;
        add_column :users, :jira_username, :string, :null => true, :default => nil;
        add_column :users, :jira_password, :string, :null => true, :default => nil;
        add_column :users, :jira_filter_id, :integer, :null => true, :default => nil;
    end

    def self.down
        remove_column :users, :jira_host;
        remove_column :users, :jira_username;
        remove_column :users, :jira_password;
        remove_column :users, :jira_filter_id;
    end
end
