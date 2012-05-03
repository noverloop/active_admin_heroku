require 'spec_helper'


describe ActiveAdmin::Views::Pages::Index do

  class ::BarDecorator
    class CollectionProxy
      attr_reader :collection
      def initialize(collection)
        @collection = collection
      end
    end
    def self.decorate(collection)
      CollectionProxy.new(collection)
    end
  end

  module ::FooBarModule
    class FooBarDecorator
    end
  end

  let(:resource_class_name) { 'Foo' }
  let(:page_presenter) { ActiveAdmin::PagePresenter.new }
  let(:active_admin_config) { mock(:resource_class => mock(:name => resource_class_name)) }

  let(:page) do
    ActiveAdmin::Views::Pages::Index.new({}, nil).tap do |page|
      page.stub!(:active_admin_config => active_admin_config, :config => page_presenter)
    end
  end

  describe '#resource_decorator' do
    context 'When the resource has no decorator' do
      it "normally returns nil" do
        page.resource_decorator.should be_nil
      end
    end

    context 'When a decorator is offered in configuration as a string' do
      let(:page_presenter) { ActiveAdmin::PagePresenter.new :decorator => 'BarDecorator' }
      it "Returns the constantized configured decorator" do
        page.resource_decorator.should == BarDecorator
      end
    end

    context 'When a decorator is offered in configuration as a class' do
      let(:page_presenter) { ActiveAdmin::PagePresenter.new :decorator => BarDecorator }
      it "Returns the configured decorator" do
        page.resource_decorator.should == BarDecorator
      end
    end

    context 'When there is a decorator defined with the guessable name' do
      let(:resource_class_name) { 'Bar' }
      it "Returns the correct decorator" do
        page.resource_decorator.should == ::BarDecorator
      end

      context 'and configuration specifies not to use the decorator' do
        let(:page_presenter) { ActiveAdmin::PagePresenter.new :decorator => nil }
        it "returns no decorator" do
          page.resource_decorator.should == nil
        end
      end
    end

    context 'When a decorator is configured that is namespaced' do
      let(:page_presenter) { ActiveAdmin::PagePresenter.new :decorator => 'FooBarModule::FooBarDecorator' }
      it "Returns the constantized configured decorator" do
        page.resource_decorator.should == ::FooBarModule::FooBarDecorator
      end
    end

  end

  describe '#decorated_collection' do
    let(:collection) { ['test'] }
    context 'When the resource has no decorator' do
      it "normally returns back the original collection" do
        page.decorated_collection(collection).should == collection
      end
    end

    context 'given a decorator' do
      let(:page_presenter) { ActiveAdmin::PagePresenter.new :decorator => BarDecorator }
      it "Returns a collection proxy" do
        page.decorated_collection(collection).should be_kind_of(::BarDecorator::CollectionProxy)
        page.decorated_collection(collection).collection.should == collection
      end
    end

  end

end
