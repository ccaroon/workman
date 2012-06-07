################################################################################
# $Id: note.rb 1319 2008-08-27 15:45:05Z ccaroon $
################################################################################
require 'rubygems';
require 'crypt/blowfish';

class Note < ActiveRecord::Base

    # NOTE: Before changing this key/passphrase, make sure you un-encrypt all
    # of your encrpyted notes.
    ENCRYPTION_KEY = "Just hard-coding the key for now.";
    #CRYPTO         = Crypt::Blowfish.new(ENCRYPTION_KEY);

    validates_presence_of :title;
    validates_presence_of :body;

    ############################################################################
    def body
        text = super;
        if (self.is_encrypted)
            text = decrypt(text);
        end

        return(text);
    end
    ############################################################################
    def body=(new_body)
        if (self.is_encrypted)
            new_body = encrypt(new_body);
        end

        super(new_body);
    end
    ############################################################################
    def is_encrypted=(new_encrypted)
        was_encrypted = self.is_encrypted;
        body          = self.body;

        super(new_encrypted);

        if (was_encrypted  != new_encrypted)
            self.body = body;
        end
    end

    private
    ############################################################################    
    def encrypt(string)
        return (CRYPTO.encrypt_string(string));
    end
    ############################################################################    
    def decrypt(string)
        return (CRYPTO.decrypt_string(string));
    end

end
