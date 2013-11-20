class Hash
  def to_condition_string
    self.symbolize_keys.to_s.delete("}").delete("{").gsub('=>', ' => ')
  end
end
