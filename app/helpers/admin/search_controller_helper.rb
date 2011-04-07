module Admin::SearchControllerHelper
  
  def to_json_for_autocomplete( results )
    results.collect do |result|
      if result.respond_to? :to_json_for_autocomplete
        result.to_json_for_autocomplete
      else
        raise Cable::Errors::SearchError::MissingInterfaceMethod , "to_json_for_autocomplete method should be defined on #{result.class.name}"
      end
    end.to_json
  end
end