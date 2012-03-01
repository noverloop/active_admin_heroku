require 'spec_helper'

describe ActiveAdmin::Views::Pages::Show do

  describe "the resource collection", pending: "I can't get tests running" do
    page = ActiveAdmin::Views::Pages::Show.new({}, nil)
    page.resource.should == nil
  end

end
