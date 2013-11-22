module LearnRails
  class Accessors
    def self.code_for(accessor)
      @accessor = accessor
      @code = <<-code.gsub(/^\s+/, '')
      code

      attributes.each do |attribute|
        @code << getter_method_for(attribute) if getter_method_needed?
        @code << setter_method_for(attribute) if setter_method_needed?
      end

      @code
    end

    private

    def self.attributes
      @accessor.drop(1).map { |attr| attr.delete(',').delete(':') }.delete_if(&:empty?)
    end

    def self.getter_method_needed?
      @getter ||= ['reader', 'accessor'].include? accessor_type
    end

    def self.setter_method_needed?
      @setter ||= ['writer', 'accessor'].include? accessor_type
    end

    def self.accessor_type
      @accessor[0].split('_')[1]
    end

    def self.getter_method_for attribute
      <<-code.gsub(/^\s+/, '')
        #{empty_comment_line_if_needed}
        # def #{attribute}
        #  @#{attribute}
        # end
      code
    end

    def self.setter_method_for attribute
      <<-code.gsub(/^\s+/, '')
        #{empty_comment_line_if_needed}
        # def #{attribute}=(value)
        #  @#{attribute} = value
        # end
      code
    end

    def self.empty_comment_line_if_needed
      @code.present? ? '#' : nil
    end
  end
end
