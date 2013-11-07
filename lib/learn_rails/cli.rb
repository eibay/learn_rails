require 'thor'
require 'learn_rails'

module LearnRails
  class CLI < Thor
    desc "rails MAGIC", "Prints out the ruby code behind any rails magic line"
    def rails(*magic)
      puts LearnRails.analyze(*magic)
    end
  end
end
