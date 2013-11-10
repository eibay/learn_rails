module LearnRails
  class Accessors
    def self.reader(accessor)
      attribute = accessor.split(' ')[1].delete ':'
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
      attribute = accessor.split(' ')[1].delete ':'
      <<-code.strip_heredoc
        # def initialize(#{attribute})
        #  @#{attribute} = #{attribute}
        # end

        # def name=(value)
        #  @#{attribute} = value
        # end
      code
    end

    def self.accessor(accessor)
      attribute = accessor.split(' ')[1].delete ':'
      <<-code.strip_heredoc
        # def initialize(#{attribute})
        #  @#{attribute} = #{attribute}
        # end

        # def #{attribute}
        #  @#{attribute}
        # end

        # def name=(value)
        #  @#{attribute} = value
        # end
      code
    end
  end
end
