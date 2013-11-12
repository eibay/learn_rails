module LearnRails
  class Accessors
    def self.code_for(accessor)
      type = accessor_type accessor
      attributes = attributes_from accessor

      code = <<-code.gsub(/^\s+/, '')
        #{initialize_method_for attributes}
      code

      attributes.each do |attribute|
        code << getter_method_for(attribute) if ['reader', 'accessor'].include? type
        code << setter_method_for(attribute) if ['writer', 'accessor'].include? type
      end

      code
    end

    private

    def self.accessor_type accessor
      accessor[0].split('_')[1]
    end

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
