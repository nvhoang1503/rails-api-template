module GrapeUtils
  class ExceptionUtils
    def self.convert_full_error_messages(hash_errors)
      results = []
      if hash_errors && hash_errors.class == Hash 
        hash_errors.keys.each do |error_h_key|
          grape_error_field = error_h_key.flatten.first
          grape_error_message = hash_errors[error_h_key].flatten.first
          results.push("#{I18n.t('grape.attributes.'+grape_error_field, :default => grape_error_field)} #{grape_error_message}")
        end
      end
      results
    end
  end
end
