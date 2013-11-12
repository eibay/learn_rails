Feature: Accessors
  In order to understand rails accessors
  As a learn_rails gem user
  I want to see the right ruby code in the terminal

  Scenario: attr_reader
    When I run `learn rails attr_reader :whatever`
    Then the output should contain "# def initialize(whatever)"
    Then the output should contain "#  @whatever = whatever"
    Then the output should contain "# end"
    Then the output should contain "# def whatever"
    Then the output should contain "#  @whatever"
    Then the output should contain "# end"

  Scenario: attr_writer
    When I run `learn rails attr_writer :whatever`
    Then the output should contain "# def initialize(whatever)"
    Then the output should contain "#  @whatever = whatever"
    Then the output should contain "# end"
    Then the output should contain "# def whatever=(value)"
    Then the output should contain "#  @whatever = value"
    Then the output should contain "# end"

  Scenario: attr_accessor
    When I run `learn rails attr_accessor :whatever`
    Then the output should contain "# def initialize(whatever)"
    Then the output should contain "#  @whatever = whatever"
    Then the output should contain "# end"
    Then the output should contain "# def whatever"
    Then the output should contain "#  @whatever"
    Then the output should contain "# end"
    Then the output should contain "# def whatever=(value)"
    Then the output should contain "#  @whatever = value"
    Then the output should contain "# end"

  Scenario: attr_reader with multiple attributes
    When I run `learn rails attr_reader :whatever, :another`
    Then the output should contain "# def initialize(whatever, another)"
    Then the output should contain "#  @whatever = whatever"
    Then the output should contain "#  @another = another"
    Then the output should contain "# end"
    Then the output should contain "# def whatever"
    Then the output should contain "#  @whatever"
    Then the output should contain "# end"
    Then the output should contain "# def another"
    Then the output should contain "#  @another"
    Then the output should contain "# end"

  Scenario: attr_writer with multiple attrributes
    When I run `learn rails attr_writer :whatever, :another`
    Then the output should contain "# def initialize(whatever, another)"
    Then the output should contain "#  @whatever = whatever"
    Then the output should contain "#  @another = another"
    Then the output should contain "# end"
    Then the output should contain "# def whatever=(value)"
    Then the output should contain "#  @whatever = value"
    Then the output should contain "# end"
    Then the output should contain "# def another=(value)"
    Then the output should contain "#  @another = value"
    Then the output should contain "# end"

  Scenario: attr_accessor with multiple attributes
    When I run `learn rails attr_accessor :whatever, :another`
    Then the output should contain "# def initialize(whatever, another)"
    Then the output should contain "#  @whatever = whatever"
    Then the output should contain "#  @another = another"
    Then the output should contain "# end"
    Then the output should contain "# def whatever"
    Then the output should contain "#  @whatever"
    Then the output should contain "# end"
    Then the output should contain "# def whatever=(value)"
    Then the output should contain "#  @whatever = value"
    Then the output should contain "# end"
    Then the output should contain "# def another"
    Then the output should contain "#  @another"
    Then the output should contain "# end"
    Then the output should contain "# def another=(value)"
    Then the output should contain "#  @another = value"
    Then the output should contain "# end"
