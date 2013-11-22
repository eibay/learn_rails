Feature: Associations
  In order to understand rails associations
  As a learn_rails gem user
  I want to see the right ruby code in the terminal

  Scenario: belongs_to association
    When I run `learn rails task belongs_to :user`
    Then the output should contain:
      """
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
      """

  Scenario: belongs_to association without the model name
    When I run `learn rails belongs_to :user`
    Then the output should contain:
      """
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
      """

  Scenario: belongs_to association with multi-word model
    When I run `learn rails manual belongs_to :car_part`
    Then the output should contain:
      """
      # def car_part(force_reload = false)
      #   @car_part = nil if force_reload
      #   @car_part ||= CarPart.find_by_id(self.car_part_id)
      # end
      #
      # def car_part=(car_part)
      #   self.car_part_id = car_part.id
      # end
      #
      # def build_car_part(attributes = {})
      #   self.car_part = CarPart.new(attributes)
      # end
      #
      # def create_car_part(attributes = {})
      #   self.car_part = CarPart.create(attributes)
      # end
      #
      # def create_car_part!(attributes = {})
      #   self.car_part = CarPart.create!(attributes)
      # end
      """
    And the output should not contain "carpart"
    And the output should not contain "Car_Part"

  Scenario: belongs_to association with :class_name option
    When I run `learn rails task belongs_to :user, class_name: "Person"`
    Then the output should contain:
      """
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
      """
    And the output should not contain "#   @user ||= User.find_by_id(self.user_id)"
    And the output should not contain "#   self.user = User.new(attributes)"
    And the output should not contain "#   self.user = User.create(attributes)"
    And the output should not contain "#   self.user = User.create!(attributes)"

  Scenario: belongs_to association with :foreign_key option
    When I run `learn rails task belongs_to :user, foreign_key: "person_id"`
    Then the output should contain:
      """
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
      """
    And the output should not contain "#   @user ||= User.find_by_id(self.user_id)"
    And the output should not contain "#   self.user_id = user.id"

  Scenario: belongs_to association with :primary_key option
    When I run `learn rails task belongs_to :user, primary_key: "todo_id"`
    Then the output should contain:
      """
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
      """
    And the output should not contain "#   self.user_id = user.id"

  Scenario: belongs_to association with :readonly option
    When I run `learn rails task belongs_to :user, readonly: true`
    Then the output should contain:
      """
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
      """
    And the output should not contain "# def user=(user)"
    And the output should not contain "#   self.user_id = user.id"

  Scenario: belongs_to association with :conditions option
    When I run `learn rails task belongs_to :user, conditions: { status: "active"}`
    And  the output should contain "# def user(force_reload = false)"
    And  the output should contain:
      """
      #   @user ||= User.first(:conditions => {:id => self.user_id, :status => "active")
      """

  Scenario: has_one association
    When I run `learn rails user has_one :task`
    Then the output should contain:
      """
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
      """

  Scenario: has_one association without the model name
    Given PENDING: Aruba process keeps hanging, need to test for terminal question
    When I run `learn rails has_one :task`
    Then the output should contain "What is the model name for this association?"

  Scenario: has_one association with model name given when prompted
    Given PENDING: Aruba process keeps hanging, need to test for terminal question
    When I run `learn rails has_one :task`
    And I type `user`
    Then the output should contain:
      """
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
      """

  Scenario: has_one association with multi-word model
    When I run `learn rails user has_one :voodoo_pop`
    Then the output should contain:
      """
      # def voodoo_pop(force_reload = false)
      #   @voodoo_pop = nil if force_reload
      #   @voodoo_pop ||= VoodooPop.find_by_user_id(self.id)
      # end
      #
      # def voodoo_pop=(voodoo_pop)
      #   voodoo_pop.user_id = self.id
      #   voodoo_pop.save
      # end
      #
      # def build_voodoo_pop(attributes = {})
      #   attributes[:user_id] = self.id
      #   VoodooPop.new(attributes)
      # end
      #
      # def create_voodoo_pop(attributes = {})
      #   attributes[:user_id] = self.id
      #   VoodooPop.create(attributes)
      # end
      #
      # def create_voodoo_pop!(attributes = {})
      #   attributes[:user_id] = self.id
      #   VoodooPop.create!(attributes)
      # end
      """
    And the output should not contain "voodoopop"
    And the output should not contain "Voodoo_Pop"

  Scenario: has_one association with :class_name option using the old hash syntax
    When I run `learn rails user has_one :task, :class_name => "ToDo"`
    Then the output should contain:
      """
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
      """
    And the output should not contain "#   @task ||= Task.find_by_user_id(self.id)"
    And the output should not contain "#   Task.new(attributes)"
    And the output should not contain "#   Task.create(attributes)"
    And the output should not contain "#   Task.create!(attributes)"

  Scenario: has_one association with :class_name option using the new hash syntax
    When I run `learn rails user has_one :task, class_name: "ToDo"`
    Then the output should contain:
      """
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
      """
    And the output should not contain "#   @task ||= Task.find_by_user_id(self.id)"
    And the output should not contain "#   Task.new(attributes)"
    And the output should not contain "#   Task.create(attributes)"
    And the output should not contain "#   Task.create!(attributes)"

  Scenario: has_one association with :foreign_key option
    When I run `learn rails user has_one :task, foreign_key: "employee_id"`
    Then the output should contain:
      """
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
      """
    And the output should not contain "#   @task ||= Task.find_by_user_id(self.id)"
    And the output should not contain "#   task.user_id = self.id"
    And the output should not contain "#   attributes[:user_id] = self.id"
    And the output should not contain "#   attributes[:user_id] = self.id"
    And the output should not contain "#   attributes[:user_id] = self.id"

  Scenario: has_one association with :primary_key option
    When I run `learn rails user has_one :task, primary_key: "primary_id"`
    Then the output should contain:
      """
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
      """
    And the output should not contain "#   @task ||= Task.find_by_user_id(self.id)"
    And the output should not contain "#   task.user_id = self.id"
    And the output should not contain "#   attributes[:user_id] = self.id"
    And the output should not contain "#   attributes[:user_id] = self.id"
    And the output should not contain "#   attributes[:user_id] = self.id"

  Scenario: has_one association with :readonly option
    When I run `learn rails user has_one :task, readonly: true`
    Then the output should contain:
      """
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
      """
    And the output should not contain "# def task="
    And the output should not contain "#   task.user_id = self.id"

  Scenario: has_many association
    When I run `learn rails user has_many :tasks`
    Then the output should contain:
      """
      # def tasks
      #   Task.where(user_id: self.id)
      # end
      """

  Scenario: has_many association without the model name
    Given PENDING: Aruba process keeps hanging, need to test for terminal question
    When I run `learn rails has_many :tasks`
    Then the output should contain "What is the model name for this association?"

  Scenario: has_many association with model name given when prompted
    Given PENDING: Aruba process keeps hanging, need to test for terminal question
    When I run `learn rails has_many :tasks`
    And I type `user`
    Then the output should contain:
      """
      # def tasks
      #   Task.where(user_id: self.id)
      # end
      """

  Scenario: has_many association with multi-word model
    When I run `learn rails user has_many :car_parts`
    Then the output should contain:
      """
      # def car_parts
      #   CarPart.where(user_id: self.id)
      # end
      """
    And the output should not contain "carpart"
    And the output should not contain "Car_Part"

  Scenario: non valid rails magic
   When I run `learn rails random gibberish`
   Then the output should contain "No ruby code available."
   And  the output should contain "See http://www.github.com/pjc/learn_rails for list of valid instructions."
