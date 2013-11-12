module LearnRails
  class Accessors
    def self.reader(accessor)
      attributes = attributes_from accessor

      code = <<-code.gsub(/^\s+/, '')
        #{initialize_method_for attributes}
      code

      attributes.each do |attribute|
        code << getter_method_for(attribute)
      end

      code
    end

    def self.writer(accessor)
      attributes = attributes_from accessor

      code = <<-code.gsub(/^\s+/, '')
        #{initialize_method_for attributes}
      code

      attributes.each do |attribute|
        code << setter_method_for(attribute)
      end

      code
    end

    def self.accessor(accessor)
      attributes = attributes_from accessor

      code = <<-code.gsub(/^\s+/, '')
        #{initialize_method_for attributes}
      code

      attributes.each do |attribute|
        code << getter_method_for(attribute)
        code << setter_method_for(attribute)
      end

      code
    end

    private

    def self.attributes_from accessor
      accessor.shift
      accessor.map { |attr| attr.delete(',').delete(':') }
    end

    def self.initialize_method_for attributes
      <<-code.gsub(/^\s+/, '')
        # def initialize(#{attributes.join ', '})
        #{attributes.map { |attr| "#  @#{attr} = #{attr}" }.join("\n")}
        # end
      code
    end

    def self.getter_method_for attribute
      <<-code.gsub(/^\s+/, '')
        #
        # def #{attribute}
        #  @#{attribute}
        # end
      code
    end

    def self.setter_method_for attribute
      <<-code.gsub(/^\s+/, '')
        #
        # def #{attribute}=(value)
        #  @#{attribute} = value
        # end
      code
    end
  end
end
