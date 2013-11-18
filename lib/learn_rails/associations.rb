module LearnRails
  class Associations
    def self.code_for(association)
      params = params association
      "LearnRails::Associations::#{params[:association].camelize}".constantize.send(:code_for, params)
    end

    private

    def self.params association
      association = clean_up association

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
  end
end
