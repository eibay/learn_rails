Feature: Accessors
  In order to understand rails accessors
  As a learn_rails gem user
  I want to see the right ruby code in the terminal

  Scenario: attr_reader
    When I run `learn rails attr_reader :whatever`
    Then the output should contain:
      """
      # def whatever
      #  @whatever
      # end
      """

  Scenario: attr_writer
    When I run `learn rails attr_writer :whatever`
    Then the output should contain:
      """
      # def whatever=(value)
      #  @whatever = value
      # end
      """

  Scenario: attr_accessor
    When I run `learn rails attr_accessor :whatever`
    Then the output should contain:
      """
      # def whatever
      #  @whatever
      # end
      #
      # def whatever=(value)
      #  @whatever = value
      # end
      """

  Scenario: attr_reader with anymodelname
    When I run `learn rails anymodelname attr_reader :whatever`
    Then the output should contain:
      """
      # def whatever
      #  @whatever
      # end
      """

  Scenario: attr_writer with anymodelname
    When I run `learn rails anymodelname attr_writer :whatever`
    Then the output should contain:
      """
      # def whatever=(value)
      #  @whatever = value
      # end
      """

  Scenario: attr_accessor with anymodelname
    When I run `learn rails anymodelname attr_accessor :whatever`
    Then the output should contain:
      """
      # def whatever
      #  @whatever
      # end
      #
      # def whatever=(value)
      #  @whatever = value
      # end
      """

  Scenario: attr_reader with multiple attributes
    When I run `learn rails attr_reader :whatever, :another`
    Then the output should contain:
      """
      # def whatever
      #  @whatever
      # end
      #
      # def another
      #  @another
      # end
      """

  Scenario: attr_writer with multiple attrributes
    When I run `learn rails attr_writer :whatever, :another`
    Then the output should contain:
      """
      # def whatever=(value)
      #  @whatever = value
      # end
      #
      # def another=(value)
      #  @another = value
      # end
      """

  Scenario: attr_accessor with multiple attributes
    When I run `learn rails attr_accessor :whatever, :another`
    Then the output should contain:
      """
      # def whatever
      #  @whatever
      # end
      #
      # def whatever=(value)
      #  @whatever = value
      # end
      #
      # def another
      #  @another
      # end
      #
      # def another=(value)
      #  @another = value
      # end
      """

  Scenario: valid statement but with comma right after
    When I run `learn rails attr_reader :whatever,`
    Then the output should not contain ","

  Scenario: valid statement but with standalone comma after it
    When I run `learn rails attr_reader :whatever ,`
    Then the output should not contain ","
    And  the output should not contain "@ "
