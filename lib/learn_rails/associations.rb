module LearnRails
  class Associations
    def self.code_for(association)
      params = params association
      self.send(params[:association], params)
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

    def self.belongs_to(params)
      associate_model = (params[:class_name] || params[:associate]).camelize
      foreign_id      = params[:foreign_key] || params[:associate] + "_id"
      primary_id      = params[:primary_key] || "id"

      <<-code.gsub(/^\s+/, '')
        # def #{params[:associate]}
        #   #{associate_model}.find_by_id(self.#{foreign_id})
        # end
        #{ belongs_to_setter_method(params, foreign_id, primary_id) unless params[:readonly] }
        #
        # def build_#{params[:associate]}(attributes = {})
        #   self.#{params[:associate]} = #{associate_model}.new(attributes)
        # end
        #
        # def create_#{params[:associate]}(attributes = {})
        #   self.#{params[:associate]} = #{associate_model}.create(attributes)
        # end
        #
        # def create_#{params[:associate]}!(attributes = {})
        #   self.#{params[:associate]} = #{associate_model}.create!(attributes)
        # end
      code
    end

    def self.has_one(params)
      associate_model = (params[:class_name] || params[:associate]).camelize
      foreign_id      = params[:foreign_key] || params[:model] + "_id"
      primary_id      = params[:primary_key] || "id"

      <<-code.gsub(/^\s+/, '')
        # def #{params[:associate]}(force_reload = false)
        #   @#{params[:associate]} = nil if force_reload
        #   @#{params[:associate]} ||= #{associate_model}.find_by_#{foreign_id}(self.#{primary_id})
        # end
        #{ has_one_setter_method(params, foreign_id, primary_id) unless params[:readonly] }
        #
        # def build_#{params[:associate]}(attributes = {})
        #   attributes[:#{foreign_id}] = self.#{primary_id}
        #   #{associate_model}.new(attributes)
        # end
        #
        # def create_#{params[:associate]}(attributes = {})
        #   attributes[:#{foreign_id}] = self.#{primary_id}
        #   #{associate_model}.create(attributes)
        # end
        #
        # def create_#{params[:associate]}!(attributes = {})
        #   attributes[:#{foreign_id}] = self.#{primary_id}
        #   #{associate_model}.create!(attributes)
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

    def self.belongs_to_setter_method params, foreign_id, primary_id
      <<-code.gsub(/^\s+/, '')
        #
        # def #{params[:associate]}=(#{params[:associate]})
        #   self.#{foreign_id} = #{params[:associate]}.#{primary_id}
        # end
      code
    end

    def self.has_one_setter_method params, foreign_id, primary_id
      <<-code.gsub(/^\s+/, '')
        #
        # def #{params[:associate]}=(#{params[:associate]})
        #   #{params[:associate]}.#{foreign_id} = self.#{primary_id}
        #   #{params[:associate]}.save
        # end
      code
    end
  end
end
