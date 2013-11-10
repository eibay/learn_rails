module LearnRails
  class Accessors
    def self.reader(accessor)
      attribute = get_attribute_from accessor
      <<-code.strip_heredoc
        # def initialize(#{attribute})
        #  @#{attribute} = #{attribute}
        # end

        # def #{attribute}
        #  @#{attribute}
        # end
      code
    end

    def self.writer(accessor)
      attribute = get_attribute_from accessor
      <<-code.strip_heredoc
        # def initialize(#{attribute})
        #  @#{attribute} = #{attribute}
        # end

        # def #{attribute}=(value)
        #  @#{attribute} = value
        # end
      code
    end

    def self.accessor(accessor)
      attribute = get_attribute_from accessor
      <<-code.strip_heredoc
        # def initialize(#{attribute})
        #  @#{attribute} = #{attribute}
        # end

        # def #{attribute}
        #  @#{attribute}
        # end

        # def #{attribute}=(value)
        #  @#{attribute} = value
        # end
      code
    end

    def self.get_attribute_from accessor
      attribute = accessor[1].delete ':'
    end
  end
end
