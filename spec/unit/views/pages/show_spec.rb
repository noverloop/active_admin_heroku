require 'spec_helper'


describe ActiveAdmin::Views::Pages::Show do

  describe "the resource collection" do

    context 'when the resource does not respond to #decorator' do
      let(:helpers) do
        Module.new.tap do |m|
          def m.resource
            'Test Resource'
          end
        end
      end

      it "normally returns the resource" do
        # puts helpers.resource
        page = ActiveAdmin::Views::Pages::Show.new({}, helpers)
        page.resource_with_decorator.should == 'Test Resource'
      end
    end


    context 'when the resource responds to #decorator' do
      let(:helpers) do
        Module.new.tap do |m|
          def m.resource
            'Test Resource'.tap do |r|
              def r.decorator
                'Decorated Resource'
              end
            end
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
