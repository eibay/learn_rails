require 'learn_rails'

describe LearnRails::Associations do
  context "should return should return the right commented out ruby code for association:" do
    it "Task belongs_to :user" do
      LearnRails::Associations.code_for(%w(Task belongs_to :user)).should eql belongs_to_code
    end

    it "User has_one :task" do
      LearnRails::Associations.code_for(%w(User has_one :task)).should eql has_one_code
    end

    it "User has_one :task, :class_name => :to_do" do
      [%w(User has_one :task, :class_name => :to_do), %w(User has_one :task, class_name: :to_do)].each do |association|
        LearnRails::Associations.code_for(association).should eql has_one_with_class_name_code
      end
    end

    it "User has_many :tasks" do
      LearnRails::Associations.code_for(%w(User has_many :tasks)).should eql has_many_code
    end
  end

  private

  def belongs_to_code
    <<-code.gsub(/^\s+/, '')
      # def user
      #   User.find_by_id(self.user_id)
      # end
    code
  end

  def has_one_code
    <<-code.gsub(/^\s+/, '')
      # def task(force_reload = false)
      #   @task = nil if force_reload
      #   @task ||= Task.find_by_user_id(self.id)
      # end
      #
      # def task=(task)
      #   task.user_id = self.id
      #   task.save
      # end
      #
      # def build_task(attributes = {})
      #   attributes[:user_id] = self.id
      #   Task.new(attributes)
      # end
      #
      # def create_task(attributes = {})
      #   attributes[:user_id] = self.id
      #   Task.create(attributes)
      # end
      #
      # def create_task!(attributes = {})
      #   attributes[:user_id] = self.id
      #   Task.create!(attributes)
      # end
    code
  end

  def has_one_with_class_name_code
    <<-code.gsub(/^\s+/, '')
      # def task(force_reload = false)
      #   @task = nil if force_reload
      #   @task ||= ToDo.find_by_user_id(self.id)
      # end
      #
      # def task=(task)
      #   task.user_id = self.id
      #   task.save
      # end
      #
      # def build_task(attributes = {})
      #   attributes[:user_id] = self.id
      #   ToDo.new(attributes)
      # end
      #
      # def create_task(attributes = {})
      #   attributes[:user_id] = self.id
      #   ToDo.create(attributes)
      # end
      #
      # def create_task!(attributes = {})
      #   attributes[:user_id] = self.id
      #   ToDo.create!(attributes)
      # end
    code
  end

  def has_many_code
    <<-code.gsub(/^\s+/, '')
      # def tasks
      #   Task.where(user_id: self.id)
      # end
    code
  end
end
