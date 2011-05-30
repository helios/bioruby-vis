module Bio
  class Image::Bar < Bio::Image
    
    def svg      
      # TODO : check bellow should be done in initializer
      if @width < @dataset[:y].size
        @height *= @dataset[:y].size.to_f / @width
        @width = @dataset[:y].size
      end
      
      scaled_data = @dataset[:y].scale(@height)
      
      distance_from_the_bottom = (scaled_data.min > 0 ? 0 : scaled_data.min.abs)
      
      width_of_bar_and_space = @width / @dataset[:y].size      
      width_of_bar = (width_of_bar_and_space * 0.5).ceil
      width_of_space = width_of_bar_and_space - width_of_bar
      
      left_margin = width_of_space / 2
      
      panel = pv.Panel.new.width(@width).height(@height)
        
      panel.add(pv.Bar).
        data(scaled_data).
        bottom(lambda {|b| b > 0 ? distance_from_the_bottom : distance_from_the_bottom + b}).
        height(lambda {|h| h.abs}).
        width(width_of_bar).
        left(lambda {left_margin + index * width_of_bar_and_space})
      
      panel.render      
      panel.to_svg
    end
    
  end
end