module ActiveAdmin
  module Views

    # div 
    #   .panel-title-bar
    #     .panel-title-bar-left
    #       h3
    #     .panel-title-bar-right
    #       
    #   .panel-contents
    #
    #   .panel-footer
    # end
    #
    # panel "Hello World", 
    # :title_bar_right => link_to("More Details"), 
    # :footer => "Less Details... :) " do
    #   para do
    #   end
    #
    #   footer do
    #   end
    # end

    class Panel < ActiveAdmin::Component
      builder_method :panel

      def build(*args)
        options = args.extract_options!
        @options = options
        @title = args.first

        add_class "panel"

        build_title_bar
        build_panel_contents

        super(options)
      end

      def add_child(child)
        if @panel_contents
          @panel_contents << child
        else
          super
        end
      end

      # Override children? to only report children when the panel's
      # contents have been added to. This ensures that the panel
      # correcly appends string values, etc.
      def children?
        @panel_contents.children?
      end

      private

      def build_title_bar
        @title_bar = div(:class => "panel_title_bar") do
          @title_bar_left = build_title_bar_left
          @title_bar_right = build_title_bar_right
        end
      end

      def build_title_bar_left
        title_content = default_title || @options.delete(:title_bar_left)

        div(title_content, :class => "panel_title_bar_left")
      end

      def default_title
        return nil unless @title 

        icon_name = @options.delete(:icon)
        icn = icon_name ? icon(icon_name) : "" 

        h3(icn + @title.to_s)
      end

      def build_title_bar_right
        div @options.delete(:title_bar_right), :class => "panel_title_bar_right"
      end

      def build_panel_contents
        @panel_contents = div(:class => "panel_contents")
      end

    end

  end
end
