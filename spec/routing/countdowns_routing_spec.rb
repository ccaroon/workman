require 'spec_helper'

describe CountdownsController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/countdowns" }.should route_to(:controller => "countdowns", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/countdowns/new" }.should route_to(:controller => "countdowns", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/countdowns/1" }.should route_to(:controller => "countdowns", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/countdowns/1/edit" }.should route_to(:controller => "countdowns", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/countdowns" }.should route_to(:controller => "countdowns", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/countdowns/1" }.should route_to(:controller => "countdowns", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/countdowns/1" }.should route_to(:controller => "countdowns", :action => "destroy", :id => "1") 
    end
  end
end
