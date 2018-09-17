class Merchant
  attr_reader :id,
              :created_at
  attr_accessor :name

  def initialize(data)
    @id = data[:id].to_i
    @name = data[:name]
    @created_at  = Time.parse(data[:created_at].to_s)
  end

end
