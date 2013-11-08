require "learn_rails/version"
require "learn_rails/associations"
require "active_support/core_ext/string"

module LearnRails
  def self.analyze(*magic)
    association       = magic.join(' ')
    association_type  = magic[1]
    case association_type
    when 'belongs_to'
      LearnRails::Associations.belongs_to(association)
    when 'has_one'
      LearnRails::Associations.has_one(association)
    when 'has_many'
      LearnRails::Associations.has_many(association)
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
