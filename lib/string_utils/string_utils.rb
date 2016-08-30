module StringUtils
  def self.numeric?(number)
    Float(number) != nil rescue false
  end
  
  def self.to_bool(value)
    return true if value == true || value =~ (/^(true|t|yes|y|1)$/i)
    return false if value == false || value =~ (/^(false|f|no|n|0)$/i)
    return nil
  end
  
  def self.boolean?(value)
    StringUtils.to_bool(value) != nil
  end

end
