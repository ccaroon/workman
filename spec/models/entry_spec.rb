################################################################################
# $Id: entry_spec.rb 1727 2009-12-14 16:51:04Z ccaroon $
################################################################################
require 'spec_helper'

describe Entry do

    before(:each) do
        @valid_attributes =
        {
            :task_date => Time.local(2009,12,25),
            :entry_date => Time.local(2009,12,25,17,30,00),
            :ticket_num => 'MIDEV-1234',
            :subject => 'Entry subject',
            :description => 'Entry Description goes here.',
            :category => Entry::CATEGORY_OTHER,
        }
    end

    it "should create a new instance given valid attributes" do
        Entry.create!(@valid_attributes)
    end

    it "should default entry_date to NOW if not specified" do
        @valid_attributes[:entry_date] = nil;
        entry = Entry.new(@valid_attributes);

        entry.save!;

        entry.entry_date.should_not be_nil;
        entry.entry_date.year.should == Time.now().year;
        entry.entry_date.month.should == Time.now().month;
        entry.entry_date.day.should == Time.now().day;
        entry.entry_date.hour.should == Time.now().hour;
        entry.entry_date.min.should == Time.now().min;
    end

end
