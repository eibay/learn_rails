module LearnRails
  class Associations
    def self.code_for(association)
      params = params association
      self.send(params[:association], params)
    end

    private

    def self.belongs_to(params)
      associate_model  = params[:associate].camelize

      <<-code.gsub(/^\s+/, '')
        # def #{params[:associate]}
        #   #{associate_model}.find_by_id(self.#{params[:associate]}_id)
        # end
      code
    end

    def self.has_many(params)
      associate_model = params[:associate].singularize.camelize

      <<-code.gsub(/^\s+/, '')
        # def #{params[:associate]}
        #   #{associate_model}.where(#{params[:model]}_id: self.id)
        # end
      code
    end

    def self.has_one(params)
      associate_model = (params[:class_name] || params[:associate]).camelize

      <<-code.gsub(/^\s+/, '')
        # def #{params[:associate]}(force_reload = false)
        #   @#{params[:associate]} = nil if force_reload
        #   @#{params[:associate]} ||= #{associate_model}.find_by_#{params[:model]}_id(self.id)
        # end
        #
        # def #{params[:associate]}=(#{params[:associate]})
        #   #{params[:associate]}.#{params[:model]}_id = self.id
        #   #{params[:associate]}.save
        # end
        #
        # def build_#{params[:associate]}(attributes = {})
        #   attributes[:#{params[:model]}_id] = self.id
        #   #{associate_model}.new(attributes)
        # end
        #
        # def create_#{params[:associate]}(attributes = {})
        #   attributes[:#{params[:model]}_id] = self.id
        #   #{associate_model}.create(attributes)
        # end
        #
        # def create_#{params[:associate]}!(attributes = {})
        #   attributes[:#{params[:model]}_id] = self.id
        #   #{associate_model}.create!(attributes)
        # end
      code
    end

    def self.params association
      association = clean_up association

      params = {}
      params[:model]        = association.shift
      params[:association]  = association.shift
      params[:associate]    = association.shift

      options_specified = Hash[*association]

      params.merge!(options_specified).symbolize_keys!
    end

    def self.clean_up association
      association.delete "=>"
      association.map! { |e| e.delete(':').delete(',').downcase }
    end
  end
end
