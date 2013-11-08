require "learn_rails/version"
require "learn_rails/associations"
require "active_support/core_ext/string"

module LearnRails
  def self.analyze(*magic)
    a,b,c = *magic
    case b
    when 'belongs_to'
      LearnRails::Associations.belongs_to(*magic.join(' '))
    when 'has_one'
      LearnRails::Associations.has_one(*magic.join(' '))
    when 'has_many'
      LearnRails::Associations.has_many(*magic.join(' '))
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
