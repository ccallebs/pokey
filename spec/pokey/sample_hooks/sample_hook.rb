class SampleHook < Pokey::Hook
  def destination
    "http://test.com/sample/hook"
  end

  def interval
    7200
  end

  def data
    { 
      name: "Sample hook",
      id: 1
    }
  end
end
