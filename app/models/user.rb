################################################################################
# $Id: user.rb 1333 2008-09-03 14:14:58Z ccaroon $
################################################################################
require 'digest/sha1';
class User < ActiveRecord::Base

    validates_presence_of   :name;
    validates_uniqueness_of :name;
    validates_presence_of   :user_name;
    validates_presence_of   :password;

    belongs_to :pref;

    ############################################################################
    def password=(new_password)
        super(Digest::SHA1.hexdigest(new_password));
    end
    ############################################################################
    def self.authenticate(user_name,password)
        user = User.find_by_user_name(user_name);

        if (!user.nil?)
            expected_passwd = Digest::SHA1.hexdigest(password);
            user = nil unless user.password == expected_passwd;
        end

        return (user);
    end
    ############################################################################
    def before_create
        pref = Pref.new();
        pref.save!;
        self.pref = pref;
    end
end
