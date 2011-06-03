module Bio
  class Image
    
    DEFAULT_HEIGHT = 300
    DEFAULT_WIDTH = 300
    
    ATTRIBUTES = [:title, :author, :date, :height, :width]
    
    attr_accessor :dataset, *ATTRIBUTES
    
    def initialize dataset, options = {}
      @dataset = dataset
      
      ATTRIBUTES.each { |attr| send("#{attr}=", options[attr]) }
      
      set_default_options
    end
    
    def display
      self.svg.display
    end
    
    private
    
    def set_default_options
      @date ||= Time.now
      
      @height ||= DEFAULT_HEIGHT
      @width ||= DEFAULT_WIDTH
      
      if @width < @dataset[:y].size
        @height *= @dataset[:y].size.to_f / @width
        @width = @dataset[:y].size
      end
    end
    
  end
end