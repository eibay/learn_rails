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
    Then the output should contain "#   Task.find_by_user_id(self.id)"
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
