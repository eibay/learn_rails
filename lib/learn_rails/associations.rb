module LearnRails
  class Associations
    def self.code_for(association)
      params = params association
      "LearnRails::Associations::#{params[:association].camelize}".constantize.send(:code_for, params)
    end

    private

    def self.params association
      association = clean_up association
      detect_conditions_option association
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

    def self.detect_conditions_option association
      if association.include? "conditions"
        index = association.index "conditions"
        conditions = []
        start = false
        association[index..-1].each do |opt|
          if opt.include?('{')
            start = true
            association.delete(opt)
            conditions << opt.delete('{') if opt.length > 1
            next
          end

          if opt.include?('}')
            start = false
            association.delete(opt)
            conditions << opt.delete('}') if opt.length > 1
            next
          end

          if start
            association.delete(opt)
            conditions << opt
          end
        end
        association.insert(index+1, Hash[*conditions.flatten])
      end
    end
  end
end
