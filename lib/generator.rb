require 'erb'
require_relative 'problem'
require_relative 'exercise'
require_relative 'test_suite'
require_relative 'generator/map_problem'
require_relative 'generator/select_problem'
require_relative 'generator/reject_problem'
require_relative 'generator/any_problem'

class Generator
  def self.problems
    [
      MapProblem,
      SelectProblem,
      RejectProblem,
      AnyProblem
    ]
  end

  def self.generate
    generate_exercises
    generate_solutions
  end

  def self.generate_exercises
    problems.each do |problem|
      problem.test_suites.each do |suite|
        File.open("./exercises/#{suite.filename}", 'wb') do |file|
          file.write suite.render('./lib/templates/suite.erb')
        end
      end
    end
  end

  def self.generate_solutions
    problems.each do |problem|
      problem.test_suites.each do |suite|
        suite.problems.each {|p| p.example!}
        File.open("./test/solutions/#{suite.filename}", 'wb') do |file|
          file.write suite.render('./lib/templates/suite.erb')
        end
      end
    end
  end
end
