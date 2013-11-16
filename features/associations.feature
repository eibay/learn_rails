Feature: Associations
  In order to understand rails associations
  As a learn_rails gem user
  I want to see the right ruby code in the terminal

  Scenario: belongs_to association
    When I run `learn rails task belongs_to :user`
    Then the output should contain "# def user"
    And  the output should contain "#   User.find_by_id(self.user_id)"
    And  the output should contain "# end"

  Scenario: belongs_to association with multi-word model
    When I run `learn rails manual belongs_to :car_part`
    Then the output should contain "# def car_part"
    And  the output should contain "#   CarPart.find_by_id(self.car_part_id)"
    And  the output should contain "# end"

  Scenario: has_one association
    When I run `learn rails user has_one :task`
    Then the output should contain "# def task(force_reload = false)"
    And  the output should contain "#   @task = nil if force_reload"
    And  the output should contain "#   @task ||= Task.find_by_user_id(self.id)"
    And  the output should contain "# end"
    And  the output should contain "# def task=(task)"
    And  the output should contain "#   task.user_id = self.id"
    And  the output should contain "#   task.save"
    And  the output should contain "# end"
    And  the output should contain "# def build_task(attributes = {})"
    And  the output should contain "#   attributes[:user_id] = self.id"
    And  the output should contain "#   Task.new(attributes)"
    And  the output should contain "# end"
    And  the output should contain "# def create_task(attributes = {})"
    And  the output should contain "#   attributes[:user_id] = self.id"
    And  the output should contain "#   Task.create(attributes)"
    And  the output should contain "# end"
    And  the output should contain "# def create_task!(attributes = {})"
    And  the output should contain "#   attributes[:user_id] = self.id"
    And  the output should contain "#   Task.create!(attributes)"
    And  the output should contain "# end"

  Scenario: has_one association with multi-word model
    When I run `learn rails user has_one :voodoo_pop`
    Then the output should contain "# def voodoo_pop(force_reload = false)"
    And  the output should contain "#   @voodoo_pop = nil if force_reload"
    And  the output should contain "#   @voodoo_pop ||= VoodooPop.find_by_user_id(self.id)"
    And  the output should contain "# end"
    And  the output should contain "# def voodoo_pop=(voodoo_pop)"
    And  the output should contain "#   voodoo_pop.user_id = self.id"
    And  the output should contain "#   voodoo_pop.save"
    And  the output should contain "# end"
    And  the output should contain "# def build_voodoo_pop(attributes = {})"
    And  the output should contain "#   attributes[:user_id] = self.id"
    And  the output should contain "#   VoodooPop.new(attributes)"
    And  the output should contain "# end"
    And  the output should contain "# def create_voodoo_pop(attributes = {})"
    And  the output should contain "#   attributes[:user_id] = self.id"
    And  the output should contain "#   VoodooPop.create(attributes)"
    And  the output should contain "# end"
    And  the output should contain "# def create_voodoo_pop!(attributes = {})"
    And  the output should contain "#   attributes[:user_id] = self.id"
    And  the output should contain "#   VoodooPop.create!(attributes)"
    And  the output should contain "# end"

  Scenario: has_one association with :class_name option using the old hash syntax
    When I run `learn rails user has_one :task, :class_name => :to_do`
    Then the output should contain "#   @task ||= ToDo.find_by_user_id(self.id)"
    And  the output should contain "#   ToDo.new(attributes)"
    And  the output should contain "#   ToDo.create(attributes)"
    And  the output should contain "#   ToDo.create!(attributes)"
    And  the output should not contain "#   @task ||= Task.find_by_user_id(self.id)"
    And  the output should not contain "#   Task.new(attributes)"
    And  the output should not contain "#   Task.create(attributes)"
    And  the output should not contain "#   Task.create!(attributes)"

  Scenario: has_one association with :class_name option using the new hash syntax
    When I run `learn rails user has_one :task, class_name: :to_do`
    Then the output should contain "#   @task ||= ToDo.find_by_user_id(self.id)"
    And  the output should contain "#   ToDo.new(attributes)"
    And  the output should contain "#   ToDo.create(attributes)"
    And  the output should contain "#   ToDo.create!(attributes)"
    And  the output should not contain "#   @task ||= Task.find_by_user_id(self.id)"
    And  the output should not contain "#   Task.new(attributes)"
    And  the output should not contain "#   Task.create(attributes)"
    And  the output should not contain "#   Task.create!(attributes)"

  Scenario: has_one association with :foreign_key option
    When I run `learn rails user has_one :task, foreign_key: :employee_id`
    Then the output should contain "#   @task ||= Task.find_by_employee_id(self.id)"
    And  the output should contain "#   task.employee_id = self.id"
    And  the output should contain "#   attributes[:employee_id] = self.id"
    And  the output should contain "#   attributes[:employee_id] = self.id"
    And  the output should contain "#   attributes[:employee_id] = self.id"
    And  the output should not contain "#   @task ||= Task.find_by_user_id(self.id)"
    And  the output should not contain "#   task.user_id = self.id"
    And  the output should not contain "#   attributes[:user_id] = self.id"
    And  the output should not contain "#   attributes[:user_id] = self.id"
    And  the output should not contain "#   attributes[:user_id] = self.id"

  Scenario: has_one association with :primary_key option
    When I run `learn rails user has_one :task, primary_key: :primary_id`
    Then the output should contain "#   @task ||= Task.find_by_user_id(self.primary_id)"
    And  the output should contain "#   task.user_id = self.primary_id"
    And  the output should contain "#   attributes[:user_id] = self.primary_id"
    And  the output should contain "#   attributes[:user_id] = self.primary_id"
    And  the output should contain "#   attributes[:user_id] = self.primary_id"
    And  the output should not contain "#   @task ||= Task.find_by_user_id(self.id)"
    And  the output should not contain "#   task.user_id = self.id"
    And  the output should not contain "#   attributes[:user_id] = self.id"
    And  the output should not contain "#   attributes[:user_id] = self.id"
    And  the output should not contain "#   attributes[:user_id] = self.id"

  Scenario: has_one association with :readonly option
    When I run `learn rails user has_one :task, readonly: true`
    Then the output should not contain "def task="

  Scenario: has_many association
    When I run `learn rails user has_many :tasks`
    Then the output should contain "# def tasks"
    And  the output should contain "#   Task.where(user_id: self.id)"
    And  the output should contain "# end"

  Scenario: has_many association with multi-word model
    When I run `learn rails user has_many :car_parts`
    Then the output should contain "# def car_parts"
    And  the output should contain "#   CarPart.where(user_id: self.id)"
    And  the output should contain "# end"

  Scenario: non valid rails magic
   When I run `learn rails random gibberish`
   Then the output should contain "No ruby code available."
   And  the output should contain "See http://www.github.com/pjc/learn_rails for list of valid instructions."
