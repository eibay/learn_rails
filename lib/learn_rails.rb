require "learn_rails/version"
require "learn_rails/associations"
require "learn_rails/associations/belongs_to"
require "learn_rails/associations/has_one"
require "learn_rails/associations/has_many"
require "learn_rails/accessors"
require "active_support/core_ext/string"

module LearnRails
  def self.analyze(*magic)
    if accessor? magic
      remove_model_name_from magic
      LearnRails::Accessors.code_for magic
    elsif association? magic
      LearnRails::Associations.code_for magic
    else
      error_message
    end
  end

  private

  def self.accessor? magic
    (magic[0..1] & ['attr_reader', 'attr_writer', 'attr_accessor']).any?
  end

  def self.remove_model_name_from magic
    magic.shift unless ['attr_reader', 'attr_writer', 'attr_accessor'].include? magic[0]
    magic
  end

  def self.association? magic
    potential_association = magic[1]
    ['belongs_to', 'has_one', 'has_many'].include? potential_association
  end

  def self.error_message
    <<-error.gsub(/^\s+/, '')
      No ruby code available.
      See http://www.github.com/pjc/learn_rails for list of valid instructions.
    error
  end
end
