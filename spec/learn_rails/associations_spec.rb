require 'learn_rails'

describe LearnRails::Associations do
  context "belongs_to association" do
    it "without options" do
      [ %w(Task belongs_to :user),
        %w(Task belongs_to "user")
        ].each do |association|
        LearnRails::Associations.code_for(association).should eql belongs_to_code
      end
    end

    it "with class_name option" do
      [ %w(Task belongs_to :user, :class_name => :person),
        %w(Task belongs_to :user, :class_name => "person"),
        %w(Task belongs_to :user, class_name: :person),
        %w(Task belongs_to :user, class_name: "person")
        ].each do |association|
        LearnRails::Associations.code_for(association).should eql belongs_to_with_class_name_code
      end
    end

    it "with foreign_key option" do
      [ %w(Task belongs_to :user, :foreign_key => :person_id),
        %w(Task belongs_to :user, :foreign_key => "person_id"),
        %w(Task belongs_to :user, foreign_key: :person_id),
        %w(Task belongs_to :user, foreign_key: "person_id")
        ].each do |association|
        LearnRails::Associations.code_for(association).should eql belongs_to_with_foreign_key_code
      end
    end

    it "with primary_key option" do
      [ %w(Task belongs_to :user, :primary_key => :todo_id),
        %w(Task belongs_to :user, :primary_key => "todo_id"),
        %w(Task belongs_to :user, primary_key: :todo_id),
        %w(Task belongs_to :user, primary_key: "todo_id")
        ].each do |association|
        LearnRails::Associations.code_for(association).should eql belongs_to_with_primary_key_code
      end
    end

    it "with readonly option" do
      [ %w(Task belongs_to :user, :readonly => true),
        %w(Task belongs_to :user, :readonly => "true"),
        %w(Task belongs_to :user, readonly: true),
        %w(Task belongs_to :user, readonly: "true")
        ].each do |association|
        LearnRails::Associations.code_for(association).should eql belongs_to_with_readonly_code
      end
    end

    context "with conditions options" do
      context "one option" do
        it "should return the correct code" do
          [ %w(Task belongs_to :user, :conditions => { :status => "active" }),
            %w(Task belongs_to :user, :conditions => {status: "active"}),
            %w(Task belongs_to :user, :conditions => { status: "active"}),
            %w(Task belongs_to :user, :conditions => {status: "active" }),
          ].each do |association|
            LearnRails::Associations.code_for(association).should eql belongs_to_with_one_conditions_option
          end
        end
      end

      context "multiple options" do
        it "should return the correct code" do
          [ %w(Task belongs_to :user, :conditions => { status => "active", registered => true }),
            %w(Task belongs_to :user, :conditions => { status: "active", registered: true}),
          ].each do |association|
            LearnRails::Associations.code_for(association).should eql belongs_to_with_multiple_conditions_options
          end
        end
      end
    end
  end

  context "has_one association" do
    it "without options" do
      [ %w(User has_one :task),
        %w(User has_one "task")
        ].each do |association|
        LearnRails::Associations.code_for(association).should eql has_one_code
      end
    end

    it "with class_name option" do
      [ %w(User has_one :task, :class_name => :to_do),
        %w(User has_one :task, :class_name => "ToDo"),
        %w(User has_one :task, class_name: :to_do),
        %w(User has_one :task, class_name: "ToDo")
        ].each do |association|
        LearnRails::Associations.code_for(association).should eql has_one_with_class_name_code
      end
    end

    it "with foreign_key option" do
      [ %w(User has_one :task, :foreign_key => :employee_id),
        %w(User has_one :task, :foreign_key => "employee_id"),
        %w(User has_one :task, foreign_key: :employee_id),
        %w(User has_one :task, foreign_key: "employee_id")
        ].each do |association|
        LearnRails::Associations.code_for(association).should eql has_one_with_foreign_key_code
      end
    end

    it "with primary_key option" do
      [ %w(User has_one :task, :primary_key => :primary_id),
        %w(User has_one :task, :primary_key => "primary_id"),
        %w(User has_one :task, primary_key: :primary_id),
        %w(User has_one :task, primary_key: "primary_id")
        ].each do |association|
        LearnRails::Associations.code_for(association).should eql has_one_with_primary_key_code
      end
    end

    it "with readonly option" do
      [ %w(User has_one :task, :readonly => true),
        %w(User has_one :task, :readonly => "true"),
        %w(User has_one :task, readonly: true),
        %w(User has_one :task, readonly: "true")
        ].each do |association|
        LearnRails::Associations.code_for(association).should eql has_one_with_readonly_code
      end
    end
  end

  context "has_many association" do
    it "without options" do
      [ %w(User has_many :tasks),
        %w(User has_many "tasks")
        ].each do |association|
        LearnRails::Associations.code_for(association).should eql has_many_code
      end
    end
  end

  private

  def belongs_to_code
    <<-code.gsub(/^\s+/, '')
      # def user(force_reload = false)
      #   @user = nil if force_reload
      #   @user ||= User.find_by_id(self.user_id)
      # end
      #
      # def user=(user)
      #   self.user_id = user.id
      # end
      #
      # def build_user(attributes = {})
      #   self.user = User.new(attributes)
      # end
      #
      # def create_user(attributes = {})
      #   self.user = User.create(attributes)
      # end
      #
      # def create_user!(attributes = {})
      #   self.user = User.create!(attributes)
      # end
    code
  end

  def belongs_to_with_class_name_code
    <<-code.gsub(/^\s+/, '')
      # def user(force_reload = false)
      #   @user = nil if force_reload
      #   @user ||= Person.find_by_id(self.user_id)
      # end
      #
      # def user=(user)
      #   self.user_id = user.id
      # end
      #
      # def build_user(attributes = {})
      #   self.user = Person.new(attributes)
      # end
      #
      # def create_user(attributes = {})
      #   self.user = Person.create(attributes)
      # end
      #
      # def create_user!(attributes = {})
      #   self.user = Person.create!(attributes)
      # end
    code
  end

  def belongs_to_with_foreign_key_code
    <<-code.gsub(/^\s+/, '')
      # def user(force_reload = false)
      #   @user = nil if force_reload
      #   @user ||= User.find_by_id(self.person_id)
      # end
      #
      # def user=(user)
      #   self.person_id = user.id
      # end
      #
      # def build_user(attributes = {})
      #   self.user = User.new(attributes)
      # end
      #
      # def create_user(attributes = {})
      #   self.user = User.create(attributes)
      # end
      #
      # def create_user!(attributes = {})
      #   self.user = User.create!(attributes)
      # end
    code
  end

  def belongs_to_with_primary_key_code
    <<-code.gsub(/^\s+/, '')
      # def user(force_reload = false)
      #   @user = nil if force_reload
      #   @user ||= User.find_by_id(self.user_id)
      # end
      #
      # def user=(user)
      #   self.user_id = user.todo_id
      # end
      #
      # def build_user(attributes = {})
      #   self.user = User.new(attributes)
      # end
      #
      # def create_user(attributes = {})
      #   self.user = User.create(attributes)
      # end
      #
      # def create_user!(attributes = {})
      #   self.user = User.create!(attributes)
      # end
    code
  end

  def belongs_to_with_readonly_code
    <<-code.gsub(/^\s+/, '')
      # def user(force_reload = false)
      #   @user = nil if force_reload
      #   @user ||= User.find_by_id(self.user_id)
      # end
      #
      # def build_user(attributes = {})
      #   self.user = User.new(attributes)
      # end
      #
      # def create_user(attributes = {})
      #   self.user = User.create(attributes)
      # end
      #
      # def create_user!(attributes = {})
      #   self.user = User.create!(attributes)
      # end
    code
  end

  def belongs_to_with_one_conditions_option
    <<-code.gsub(/^\s+/, '')
      # def user(force_reload = false)
      #   @user = nil if force_reload
      #   @user ||= User.first(:conditions => {:id => self.user_id, :status => "active")
      # end
      #
      # def user=(user)
      #   self.user_id = user.id
      # end
      #
      # def build_user(attributes = {})
      #   self.user = User.new(attributes)
      # end
      #
      # def create_user(attributes = {})
      #   self.user = User.create(attributes)
      # end
      #
      # def create_user!(attributes = {})
      #   self.user = User.create!(attributes)
      # end
    code
  end

  def belongs_to_with_multiple_conditions_options
    <<-code.gsub(/^\s+/, '')
      # def user(force_reload = false)
      #   @user = nil if force_reload
      #   @user ||= User.first(:conditions => {:id => self.user_id, :status => "active", :registered => "true")
      # end
      #
      # def user=(user)
      #   self.user_id = user.id
      # end
      #
      # def build_user(attributes = {})
      #   self.user = User.new(attributes)
      # end
      #
      # def create_user(attributes = {})
      #   self.user = User.create(attributes)
      # end
      #
      # def create_user!(attributes = {})
      #   self.user = User.create!(attributes)
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

  def has_one_with_foreign_key_code
    <<-code.gsub(/^\s+/, '')
      # def task(force_reload = false)
      #   @task = nil if force_reload
      #   @task ||= Task.find_by_employee_id(self.id)
      # end
      #
      # def task=(task)
      #   task.employee_id = self.id
      #   task.save
      # end
      #
      # def build_task(attributes = {})
      #   attributes[:employee_id] = self.id
      #   Task.new(attributes)
      # end
      #
      # def create_task(attributes = {})
      #   attributes[:employee_id] = self.id
      #   Task.create(attributes)
      # end
      #
      # def create_task!(attributes = {})
      #   attributes[:employee_id] = self.id
      #   Task.create!(attributes)
      # end
    code
  end

  def has_one_with_primary_key_code
    <<-code.gsub(/^\s+/, '')
      # def task(force_reload = false)
      #   @task = nil if force_reload
      #   @task ||= Task.find_by_user_id(self.primary_id)
      # end
      #
      # def task=(task)
      #   task.user_id = self.primary_id
      #   task.save
      # end
      #
      # def build_task(attributes = {})
      #   attributes[:user_id] = self.primary_id
      #   Task.new(attributes)
      # end
      #
      # def create_task(attributes = {})
      #   attributes[:user_id] = self.primary_id
      #   Task.create(attributes)
      # end
      #
      # def create_task!(attributes = {})
      #   attributes[:user_id] = self.primary_id
      #   Task.create!(attributes)
      # end
    code
  end

  def has_one_with_readonly_code
    <<-code.gsub(/^\s+/, '')
      # def task(force_reload = false)
      #   @task = nil if force_reload
      #   @task ||= Task.find_by_user_id(self.id)
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

  def has_many_code
    <<-code.gsub(/^\s+/, '')
      # def tasks
      #   Task.where(user_id: self.id)
      # end
    code
  end
end
