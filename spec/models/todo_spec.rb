################################################################################
# $Id: todo_spec.rb 1727 2009-12-14 16:51:04Z ccaroon $
################################################################################
require 'spec_helper'

describe Todo do
    before(:each) do
        @valid_attributes =
        {
            :priority => Todo::PRIORITIES[0],
            :title => 'Must get this done soon',
            :completed => false,
        }
    end

    it "should create a new instance given valid attributes" do
        Todo.create!(@valid_attributes)
    end

end
