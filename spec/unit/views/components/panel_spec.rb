require 'spec_helper'

describe ActiveAdmin::Views::Panel do

  setup_arbre_context!

  let(:the_panel) do
    panel "My Title" do
      span("Hello World")
    end
  end

  it "should have a title h3" do
    the_panel.find_by_tag("h3").first.content.should == "My Title"
  end

  it "should have a contents div" do
    the_panel.find_by_class("panel_contents").should_not be_empty
  end

  it "should add children to the contents div" do
    the_panel.find_by_tag("span").first.parent.should == the_panel.find_by_class("panel_contents").first
  end

  it "should set the icon" do
    panel("Title", :icon => :arrow_down).find_by_tag("h3").first.content.should include("span class=\"icon")
  end

  describe "#children?" do

    it "returns false if no children have been added to the panel" do
      the_panel = panel("A Panel")
      the_panel.children?.should == false
    end

  end

  describe "full panel" do

    let(:the_panel) do
      panel "My Title", :title_bar_right => "More details..." do
      end
    end

    it "should have a title bar" do
      the_panel.find_by_class("panel_title_bar").should_not be_empty
    end

    it "should have a title bar left" do
      title_bar_left = the_panel.find_by_class("panel_title_bar_left").first
      title_bar_left.should_not be_nil
      title_bar_left.parent.class_list.should include("panel_title_bar")
    end

    it "should have an h3 title within bar left" do
      title_bar_left = the_panel.find_by_class("panel_title_bar_left").first
      title_h3 = the_panel.find_by_tag("h3").first
      title_h3.parent.should == title_bar_left
    end

    it "should have a title bar right" do
      title_bar_right = the_panel.find_by_class("panel_title_bar_right").first
      title_bar_right.should_not be_nil
      title_bar_right.parent.class_list.should include("panel_title_bar")
    end

    it "should have 'More details' into the title bar right" do
      title_bar_right = the_panel.find_by_class("panel_title_bar_right").first
      title_bar_right.content.should == "More details..."
    end
  end

  it "should set the title bar left content" do
    the_panel = panel(:title_bar_left => "Hello World")
    left_title = the_panel.find_by_class("panel_title_bar_left").first
    left_title.content.should == "Hello World"
  end

  it "should work without title" do
    the_panel = panel { "Hello" }
    the_panel.find_by_class("panel_title_bar").should_not be_empty
    the_panel.find_by_class("panel_title_bar_left").first.content.should be_empty

    contents = the_panel.find_by_class("panel_contents").first.content
    contents.should == "Hello"
  end

  it "should work with title bar right only" do
    the_panel = panel(:title_bar_right => "Hello World")
    the_panel.find_by_class("panel_title_bar_left").first.content.should be_empty
    the_panel.find_by_class("panel_title_bar_right").first.content.should == "Hello World"
  end

  it "could support footers"

end
