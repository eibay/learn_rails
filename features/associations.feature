Feature: Associations
  In order to understand rails associations
  As a learn_rails gem user
  I want to see the right ruby code in the terminal

  Scenario: belongs_to association
    When I run `learn rails task belongs_to :user`
    Then the output should contain "# def user"
    Then the output should contain "#   User.find_by_id(self.user_id)"
    Then the output should contain "# end"

  Scenario: has_one association
    When I run `learn rails user has_one :task`
    Then the output should contain "# def task"
    Then the output should contain "#   @task = nil if force_reload"
    Then the output should contain "#   @task ||= Task.find_by_user_id(self.id)"
    Then the output should contain "# end"
    Then the output should contain "# def task=(task)"
    Then the output should contain "#   task.user_id = self.id"
    Then the output should contain "#   task.save"
    Then the output should contain "# end"
    Then the output should contain "# def build_task(attributes = {})"
    Then the output should contain "#   attributes[:user_id] = self.id"
    Then the output should contain "#   Task.new(attributes)"
    Then the output should contain "# end"
    Then the output should contain "# def create_task(attributes = {})"
    Then the output should contain "#   attributes[:user_id] = self.id"
    Then the output should contain "#   Task.create(attributes)"
    Then the output should contain "# end"
    Then the output should contain "# def create_task!(attributes = {})"
    Then the output should contain "#   attributes[:user_id] = id"
    Then the output should contain "#   Task.create!(attributes)"
    Then the output should contain "# end"

  Scenario: has_many association
    When I run `learn rails user has_many :tasks`
    Then the output should contain "# def tasks"
    Then the output should contain "#   Task.where(user_id: self.id)"
    Then the output should contain "# end"

  Scenario: non valid rails magic
   When I run `learn rails random gibberish`
   Then the output should contain "No ruby code available."
   Then the output should contain "See http://www.github.com/pjc/learn_rails for list of valid instructions."

 Scenario: belongs_to association with multi-word model
   When I run `learn rails manual belongs_to :car_part`
   Then the output should contain "# def car_part"
   Then the output should contain "#   CarPart.find_by_id(self.car_part_id)"
   Then the output should contain "# end"

 Scenario: has_one association with multi-word model
   When I run `learn rails user has_one :voodoo_pop`
   Then the output should contain "# def voodoo_pop"
   Then the output should contain "#   VoodooPop.find_by_user_id(self.id)"
   Then the output should contain "# end"

 Scenario: has_many association with multi-word model
   When I run `learn rails user has_many :car_parts`
   Then the output should contain "# def car_parts"
   Then the output should contain "#   CarPart.where(user_id: self.id)"
   Then the output should contain "# end"
