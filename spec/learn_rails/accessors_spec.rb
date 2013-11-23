require 'spec_helper'

@accessors
describe LearnRails::Accessors do

  after(@accessors) do
    LearnRails::Accessors.instance_variable_set(:@getter, nil)
    LearnRails::Accessors.instance_variable_set(:@setter, nil)
  end

  context "attr" do
    context "reader" do
      context "with one attribute" do
        it "should return the correct code" do
          LearnRails::Accessors.code_for(%w(attr_reader :name)).should eql attr_reader_code
        end
      end

      context "with multiple attributes" do
        it "should return the correct code" do
          LearnRails::Accessors.code_for(%w(attr_reader :name, :another)).should eql attr_reader_two_attributes_code
        end
      end
    end

    context "writer" do
      context "with one attribute" do
        it "should return the correct code" do
          LearnRails::Accessors.code_for(%w(attr_writer :name)).should eql attr_writer_code
        end
      end

      context "with multiple attributes" do
        it "should return the correct code" do
          LearnRails::Accessors.code_for(%w(attr_writer :name, :another)).should eql attr_writer_two_attributes_code
        end
      end
    end

    context "accessor" do
      context "with one attribute" do
        it "should return the correct code" do
          LearnRails::Accessors.code_for(%w(attr_accessor :name)).should eql attr_accessor_code
        end
      end

      context "with multiple attributes" do
        it "should return the correct code" do
          LearnRails::Accessors.code_for(%w(attr_accessor :name, :another)).should eql attr_accessor_two_attributes_code
        end
      end
    end
  end

  context "with comma" do
    context "right after the last attribute" do
      it "should return the correct code" do
        LearnRails::Accessors.code_for(%w(attr_accessor :name,)).should eql attr_accessor_code
      end
    end

    context "seperated by a space" do
      it "should return the correct code" do
        LearnRails::Accessors.code_for(%w(attr_accessor :name ,)).should  eql attr_accessor_code
      end
    end
  end

  private

  def attr_reader_code
    <<-code.gsub(/^\s+/, '')
      # def name
      #  @name
      # end
    code
  end

  def attr_writer_code
    <<-code.gsub(/^\s+/, '')
      # def name=(value)
      #  @name = value
      # end
    code
  end

  def attr_accessor_code
    <<-code.gsub(/^\s+/, '')
      # def name
      #  @name
      # end
      #
      # def name=(value)
      #  @name = value
      # end
    code
  end

  def attr_reader_two_attributes_code
    <<-code.gsub(/^\s+/, '')
      # def name
      #  @name
      # end
      #
      # def another
      #  @another
      # end
    code
  end

  def attr_writer_two_attributes_code
    <<-code.gsub(/^\s+/, '')
      # def name=(value)
      #  @name = value
      # end
      #
      # def another=(value)
      #  @another = value
      # end
    code
  end

  def attr_accessor_two_attributes_code
    <<-code.gsub(/^\s+/, '')
      # def name
      #  @name
      # end
      #
      # def name=(value)
      #  @name = value
      # end
      #
      # def another
      #  @another
      # end
      #
      # def another=(value)
      #  @another = value
      # end
    code
  end
end
