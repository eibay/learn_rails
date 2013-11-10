require 'learn_rails'

describe LearnRails::Associations do
  context "should return should return the right commented out ruby code for association:" do
    it "Task belongs_to :user" do
      LearnRails::Associations.belongs_to(%w(Task belongs_to :user)).should eql belongs_to_heredoc
    end

    it "User has_one :task" do
      LearnRails::Associations.has_one(%w(User has_one :task)).should eql has_one_heredoc
    end

    it "User has_many :tasks" do
      LearnRails::Associations.has_many(%w(User has_many :tasks)).should eql has_many_heredoc
    end
  end

  private

  def belongs_to_heredoc
    <<-code.strip_heredoc
      # def user
      #   User.find_by_id(self.user_id)
      # end
    code
  end

  def has_one_heredoc
    <<-code.strip_heredoc
      # def task
      #   Task.find_by_user_id(self.id)
      # end
    code
  end

  def has_many_heredoc
    <<-code.strip_heredoc
      # def tasks
      #   Task.where(user_id: self.id)
      # end
    code
  end
end
