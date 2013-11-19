module LearnRails
  class Accessors
    def self.code_for(accessor)
      attributes = attributes_from accessor

      code = <<-code.gsub(/^\s+/, '')
      code

      attributes.each do |attribute|
        code << getter_method_for(attribute, code) if ['reader', 'accessor'].include? accessor_type(accessor)
        code << setter_method_for(attribute, code) if ['writer', 'accessor'].include? accessor_type(accessor)
      end

      code
    end

    private

    def self.accessor_type accessor
      accessor[0].split('_')[1]
    end

    def self.attributes_from accessor
      accessor.drop(1).map { |attr| attr.delete(',').delete(':') }.delete_if(&:empty?)
    end

    def self.getter_method_for attribute, code
      <<-code.gsub(/^\s+/, '')
        #{"#\n" unless code.empty?}
        # def #{attribute}
        #  @#{attribute}
        # end
      code
    end

    def self.setter_method_for attribute, code
      <<-code.gsub(/^\s+/, '')
        #{"#\n" unless code.empty?}
        # def #{attribute}=(value)
        #  @#{attribute} = value
        # end
      code
    end
  end
end
