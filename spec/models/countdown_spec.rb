################################################################################
# $Id: countdown_spec.rb 1900 2010-05-12 14:53:49Z ccaroon $
################################################################################
require 'spec_helper'

describe Countdown do
    before(:each) do
        now = Time.now();
        @valid_attributes = {
            :title       => "test",
            :target_date => Time.local(now.year,now.mon,now.day+2),
            :units       => Countdown::UNIT_DAY,
            :on_homepage => false
        }
    end

    it "should create a new instance given valid attributes" do
        Countdown.create!(@valid_attributes)
    end

    it "should be able to compute the correct amount of time left in DAYS" do
        c = Countdown.new(@valid_attributes);
        c.time_left.should == 2;
    end

    it "should be able to compute the correct amount of time left in HOURS" do
        c = Countdown.new(@valid_attributes);
        c.units = Countdown::UNIT_HOUR;
        secs = c.target_date - Time.now();
        c.time_left.should == (secs/60/60).ceil;
    end

    it "should be able to compute the correct amount of time left in MINS" do
        c = Countdown.new(@valid_attributes);
        c.units = Countdown::UNIT_MINUTE;
        secs = c.target_date - Time.now();
        c.time_left.should == (secs/60).ceil;
    end

    it "should be able to compute the correct amount of time left in SECS" do
        c = Countdown.new(@valid_attributes);
        c.units = Countdown::UNIT_SECOND;
        secs = c.target_date - Time.now();
        c.time_left.should == secs.ceil;
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
        days = (secs/86400).ceil;
        modifier = (days >= 0) ? 'Until' : 'Since';

        c.to_s.should == "#{days} Days #{modifier} Christmas";
    end

    it "should be able to deal with past target dates" do
        c = Countdown.new(@valid_attributes);
        c.target_date -= (5*86400); # minus 5 days

        c.time_left.should be < 0;
    end
end
