require 'spec_helper'


describe ActiveAdmin::Views::Pages::Show do

  describe "the resource" do
    let(:helpers) { mock(:resource => resource) }

    context 'when the resource does not respond to #decorator' do
      let(:resource) { 'Test Resource' }

      it "normally returns the resource" do
        # puts helpers.resource
        page = ActiveAdmin::Views::Pages::Show.new({}, helpers)
        page.resource_with_decorator.should == 'Test Resource'
      end
    end


    context 'when the resource responds to #decorator' do
      let(:resource) do
        'Test Resource'.tap do |r|
          def r.decorator
            'Decorated Resource'
          end
        end
      end

      it "normally returns the resource" do
        page = ActiveAdmin::Views::Pages::Show.new({}, helpers)
        page.resource_with_decorator.should == 'Decorated Resource'
      end
    end

  end

end
