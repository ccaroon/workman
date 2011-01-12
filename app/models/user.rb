################################################################################
# $Id: user.rb 2235 2010-12-13 19:54:42Z ccaroon $
################################################################################
require 'digest/sha1';
class User < ActiveRecord::Base

    MAIN_STYLES = %w(
        None
        Blue
        BlueGreen
    );

    CAL_STYLES = %w(
        blue
        blue2
        brown
        green
        system
        tas
        win2k-1
        win2k-2
        win2k-cold-1
        win2k-cold-2
    );
    
    validates_presence_of   :name;
    validates_uniqueness_of :name;
    validates_presence_of   :email;
    validates_presence_of   :user_name;
    validates_presence_of   :password;

    @user = nil;

    ############################################################################
    def self.user
        return (@user);
    end
    ############################################################################
    def self.user=(user)
        @user = user;
    end
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
    def update_email_config

        ActionMailer::Base.delivery_method = self.email_type;

        if (self.email_type == 'smtp')
            settings = {:address => self.smtp_host};

            if (self.smtp_auth != 'none')
                settings[:user_name]      = self.smtp_user;
                settings[:password]       = self.smtp_pass;
                settings[:authentication] = self.smtp_auth;
            end

            ActionMailer::Base.smtp_settings = settings;
        end
    end
end
