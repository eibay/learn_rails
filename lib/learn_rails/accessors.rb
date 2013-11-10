module LearnRails
  class Accessors
    def self.reader(accessor)
      <<-code.strip_heredoc
#{initialize_method_for attribute_from accessor}

#{getter_method_for attribute_from accessor}
      code
    end

    def self.writer(accessor)
      <<-code.strip_heredoc
#{initialize_method_for attribute_from accessor}

#{setter_method_for attribute_from accessor}
      code
    end

    def self.accessor(accessor)
      <<-code.strip_heredoc
#{initialize_method_for attribute_from accessor}

#{getter_method_for attribute_from accessor}

#{setter_method_for attribute_from accessor}
      code
    end

    private

    def self.attribute_from accessor
      attribute = accessor[1].delete ':'
    end

    def self.initialize_method_for attribute
      <<-code.strip_heredoc.chomp
        # def initialize(#{attribute})
        #  @#{attribute} = #{attribute}
        # end
      code
    end

    def self.getter_method_for attribute
      <<-code.strip_heredoc.chomp
        # def #{attribute}
        #  @#{attribute}
        # end
      code
    end

    def self.setter_method_for attribute
      <<-code.strip_heredoc.chomp
        # def #{attribute}=(value)
        #  @#{attribute} = value
        # end
      code
    end
  end
end
