################################################################################
# $Id: countdown_spec.rb 1900 2010-05-12 14:53:49Z ccaroon $
################################################################################
require 'spec_helper'

describe Countdown do
    before(:each) do
        now = Time.now();
        @valid_attributes = {
            :title       => "test",
            :target_date => Time.now() + (86400*2),
            :units       => Countdown::UNIT_DAY,
            :on_homepage => false
        }
    end

    it "should create a new instance given valid attributes" do
        Countdown.create!(@valid_attributes)
    end

    it "should be able to compute the correct amount of time left in YEARS" do
        c = Countdown.new(@valid_attributes);
        c.units = Countdown::UNIT_YEAR;
        c.target_date = Time.now() + (86400*365*12);

        c.time_left.should == 11.75;
    end
    
    it "should be able to compute the correct amount of time left in MONTHS" do
        c = Countdown.new(@valid_attributes);
        c.units = Countdown::UNIT_MONTH;
        c.target_date = Time.now() + (86400*150);

        c.time_left.should == 4.75;
    end
    
    it "should be able to compute the correct amount of time left in WEEKS" do
        c = Countdown.new(@valid_attributes);
        c.units = Countdown::UNIT_WEEK;
        c.target_date = Time.now() + (86400*21);

        c.time_left.should == 2.75;
    end
    
    it "should be able to compute the correct amount of time left in DAYS" do
        c = Countdown.new(@valid_attributes);
        c.time_left.should == 1.75;
    end

    it "should be able to compute the correct amount of time left in HOURS" do
        c = Countdown.new(@valid_attributes);
        c.units = Countdown::UNIT_HOUR;
        secs = c.target_date - Time.now();
        c.time_left.ceil.should == (secs/60/60).ceil;
    end

    it "should be able to compute the correct amount of time left in MINS" do
        c = Countdown.new(@valid_attributes);
        c.units = Countdown::UNIT_MINUTE;
        secs = c.target_date - Time.now();
        c.time_left.ceil.should == (secs/60).ceil;
    end

    it "should be able to compute the correct amount of time left in SECS" do
        c = Countdown.new(@valid_attributes);
        c.units = Countdown::UNIT_SECOND;
        secs = c.target_date - Time.now();
        c.time_left.ceil.should == secs.ceil;
    end

    it "should be able to determine units string for display" do
        c = Countdown.new(@valid_attributes);
        c.units = Countdown::UNIT_SECOND;

        c.target_date = Time.now() + 1;
        c.display_units.should == 'Second';

        c.target_date = Time.now() + 30;
        c.display_units.should == 'Seconds';
    end

    it "should have a nice, human-readable string representation" do
        c = Countdown.new(@valid_attributes);
        c.title = 'Christmas';
        c.target_date = Time.local(Time.now.year, 12, 25);

        secs = c.target_date - Time.now();
        days = (secs/86400).to_i;
        modifier = (days >= 0) ? 'Until' : 'Since';

        c.to_s.should =~ /#{days}\.\d+ Days #{modifier} Christmas/;
    end

    it "should be able to deal with past target dates" do
        c = Countdown.new(@valid_attributes);
        c.target_date -= (5*86400); # minus 5 days

        c.time_left.should be < 0;
    end
    
    it "should be able to auto-adjust the units DOWN" do
        c = Countdown.new(@valid_attributes);
        c.units = Countdown::UNIT_YEAR;
        c.target_date = Time.now() + (86400*365); # 1 year from now.
        
        # By the time this is called, it's less than 1 year (in seconds) so it
        # should downgrade to months.
        c.time_left.should == 12;
        c.units.should be Countdown::UNIT_MONTH;

        # TODO: how to control time?
        #weeks = Time.now() + (86400*8);
        #time = mock("Time");
        #time.should_receive(:now).once.and_return(weeks);
        #c.time_left.should == 1;
        #c.units.should be Countdown::UNIT_WEEKS;
        
    end
end
