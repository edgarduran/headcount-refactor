require_relative 'economic_profile'
require_relative 'statewide_testing'
require_relative 'enrollment'

class District
  attr_accessor :name
  def initialize(name, data)
    @name = name
    @data = data
  end

  def enrollment
    Enrollment.new(@name)
  end

  def economic_profile
    EconomicProfile.new(@name)
  end

  def statewide_testing
    StatewideTesting.new(@name)
  end
end
