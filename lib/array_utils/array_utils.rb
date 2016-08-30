module ArrayUtils
  def self.empty_array?(array)
    if array.try("class").try("name") == "Array"
      return (array.select {|x| !x.blank?}.size == 0)
    end
    true 
  end
end
