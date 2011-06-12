module Bio
  class Image::Heatmap < Bio::Image
  
    DEFAULT_VISUALIZE_METHOD = :to_matrix
    
    def svg
      max = min = @data[0][0]
      
      @data.each do |column|
        column.each do |field|
          max = field if field > max
          min = field if field < min
        end
      end
      
      ratio = (max - min).to_f
      
      scaled_min = min / ratio
      
      data = @data.collect do |column|
        column.collect do |field|
          field / ratio - scaled_min
        end
      end
      
      panel = pv.Panel.new.
        width(@width).
        height(@height).
        margin(1)
      
      panel.add(pv.Layout.Grid).
        rows(data).
        cell.add(pv.Bar).
          fill_style(Rubyvis.ramp("white", "blue"))

      panel.render
      
      Bio::File::Svg.new panel.to_svg
    end
    
    private
    
    def set_default_options
      super
      
      if @width < 10 * @data.size
        @width = 10 * @data.size
      end
      
      if @height < 4 * @data[0].size
        @height = 4 * @data[0].size
      end
    end
    
  end
end