class District
  def initialize(name, data)
    @name = name
    @data = data
  end

  def enrollment
    Enrollment.new(@name)
  end

  def economicprofile
    EconomicProfile.new(@name)
  end

  def statewide_testing
    StatewideTesting.new(@name)
  end
end
