# Learn Rails
[![Build Status](https://secure.travis-ci.org/pjc/learn_rails.png?branch=master)][travis]
[![Dependency Status](https://gemnasium.com/pjc/learn_rails.png)][gemnasium]
[![Code Climate](https://codeclimate.com/github/pjc/learn_rails.png)][codeclimate]
[![Coverage Status](https://coveralls.io/repos/pjc/learn_rails/badge.png?branch=master)][coveralls]

[travis]: https://travis-ci.org/pjc/learn_rails
[codeclimate]: https://codeclimate.com/github/pjc/learn_rails
[gemnasium]: https://gemnasium.com/pjc/learn_rails
[coveralls]: https://coveralls.io/r/pjc/learn_rails

Learn Ruby on Rails by seeing all the ruby code behind the rails (and ruby) magic you use.

Currently works for:
- accessors (`attr_reader`, `attr_writer`, `attr_accessor`)
- associations (`belongs_to` and `has_one` only so far)

Also note that for associations, the only options that work so far are `class_name`, `readonly`, `primary_key` and `foreign_key`.

Coming soon:
- All rails magic / helpers
- Annotate your rails app with a single command (e.g. associations code shown in each model)

## Installation

Add this line to your application's Gemfile:

    gem 'learn_rails'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install learn_rails

## Usage

This gem installs an executable called `learn` and a general purpose command called `rails`, so all you need to do is go to the terminal and type:

    $ learn rails the_rails_magic_I_want_to_learn_about

Say you want to know what the `attr_accessor :color, :size` line in one of the models in your code really does. Type the following terminal command:

    $ learn rails attr_accessor :color, :size

The gem will now print the following ruby code in your terminal output:

    # def color
    #  @color
    # end
    #
    # def color=(value)
    #  @color = value
    # end
    #
    # def size
    #  @size
    # end
    #
    # def size=(value)
    #  @size = value
    # end

Sweet!

Maybe you also want to know a bit more about the association `has_one :task, class_name: "ToDo"` in your `user.rb` model. You would now type:

    $ learn rails user has_one :task, class_name: "ToDo"

(Note that we included the model name in the command, because our gem needs it to generate the ruby code!)

This is the terminal output you'll see:

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

Happy learning!

## 2 rules to remember

1. Always use the new ruby hash syntax for the options you specify. So type `class_name: "ToDo"` and not `class_name => "ToDo"`.

2. Don't forget to prepend your associations with the ruby model they are defined in (see example above).

Don't worry too much about rule 2 though: If you forget to give the model name when we need it, we'll ask for it. And when you give it when we don't need it, we'll ignore it.

## List of available commands

Accessors:

    $ learn rails attr_reader :as, :many, :attributes, :as, :you, :want

    $ learn rails attr_writer :as, :many, :attributes, :as, :you, :want

    $ learn rails attr_accessor :as, :many, :attributes, :as, :you, :want

Associations:

    $ learn rails mymodelname belongs_to :associate

    $ learn rails mymodelname has_one :associate

Options for each association: `class_name: "Whatever"`, `foreign_key: "foreign_id"`, `primary_id: "primary_id"`, `readonly: true`

## Feedback

Comments and feedback are very welcome on [our github issues page](https://github.com/pjc/learn_rails/issues?state=open).

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
