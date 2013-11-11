require 'learn_rails'

describe LearnRails::Accessors do
  context "should return the right commented out ruby code for accessor:" do
    it "attr_reader :name" do
      LearnRails::Accessors.reader(%w(attr_reader :name)).should eql attr_reader_heredoc
    end

    it "attr_writer :name" do
      LearnRails::Accessors.writer(%w(attr_writer :name)).should eql attr_writer_heredoc
    end

    it "attr_accessor :name" do
      LearnRails::Accessors.accessor(%w(attr_accessor :name)).should eql attr_accessor_heredoc
    end
  end

  private

  def attr_reader_heredoc
    <<-code.gsub(/^\s+/, '')
      # def initialize(name)
      #  @name = name
      # end
      #
      # def name
      #  @name
      # end
    code
  end

  def attr_writer_heredoc
    <<-code.gsub(/^\s+/, '')
      # def initialize(name)
      #  @name = name
      # end
      #
      # def name=(value)
      #  @name = value
      # end
    code
  end

  def attr_accessor_heredoc
    <<-code.gsub(/^\s+/, '')
      # def initialize(name)
      #  @name = name
      # end
      #
      # def name
      #  @name
      # end
      #
      # def name=(value)
      #  @name = value
      # end
    code
  end
end
