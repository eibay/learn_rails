module LearnRails
  class Associations
    def self.code_for(association)
      params = params association
      "LearnRails::Associations::#{params[:association].camelize}".constantize.send(:code_for, params)
    end

    private

    def self.params association
      clean_up association
      hashify_conditions_options association

      params = {}
      params[:model]        = association.shift.downcase
      params[:association]  = association.shift
      params[:associate]    = association.shift

      options_specified = Hash[*association].symbolize_keys!

      params.merge!(options_specified)
    end

    def self.clean_up association
      association.delete "=>"
      association.map! { |e| e.delete(':').delete(',').delete('\"') }
    end

    def self.hashify_conditions_options association
      return association unless association.include? "conditions"

      start_options_index = association.index("conditions") + 1
      end_options_index   = association[start_options_index..-1].find_index { |e| e.match /}/ } + start_options_index

      conditions = []
      association[start_options_index..end_options_index].each do |option|
        conditions << option.delete('{').delete('}') if option.length > 1
        association.delete(option)
      end

      association.insert(start_options_index, Hash[*conditions])
    end
  end
end
