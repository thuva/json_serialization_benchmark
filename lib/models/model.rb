class Model
  def read_attribute_for_serialization(attribute)
    send(attribute)
  end
end
