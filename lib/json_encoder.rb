class JsonEncoder
  def self.dump(hash_or_array)
    Oj.dump(hash_or_array, mode: :compat)
  end
end
