class AnotherSampleHook < Pokey::Hook
  def destination
    "http://www.another.com/sample/hook"
  end

  def interval
    2400
  end

  def data
    {
      name: "Another Sample Hook",
      id: 2,
      description: "George Bluth approves."
    }
  end
end
