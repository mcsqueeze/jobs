class Input
  attr_reader :inputcars, :inputrentals, :inputoptions

  def initialize
    serialized_data = File.read(FILEPATH)
    data = JSON.parse(serialized_data, symbolize_names: true)
    @inputcars = data[:cars]
    @inputrentals = data[:rentals]
    @inputoptions = data[:options]
  end
end
