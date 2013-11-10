require "learn_rails/version"
require "learn_rails/associations"
require "learn_rails/accessors"
require "active_support/core_ext/string"

module LearnRails
  def self.analyze(*magic)
    association       = magic.join(' ')
    association_type  = magic[1]
    if ['belongs_to', 'has_one', 'has_many'].include? association_type
      LearnRails::Associations.send(association_type, association)
    else
      error_message
    end
  end

  private

  def self.error_message
    <<-error.strip_heredoc
      No ruby code available.
      See http://www.github.com/pjc/learn_rails for list of valid instructions.
    error
  end
end
