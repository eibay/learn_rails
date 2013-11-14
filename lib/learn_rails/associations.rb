module LearnRails
  class Associations
    def self.belongs_to(association)
      parent_name   = association[2].delete ':'
      parent_model  = parent_name.camelize
      <<-code.gsub(/^\s+/, '')
        # def #{parent_name}
        #   #{parent_model}.find_by_id(self.#{parent_name}_id)
        # end
      code
    end

    def self.has_many(association)
      parent_name   = association[0].downcase
      children_name = association[2].delete(':').downcase
      child_model   = children_name.singularize.camelize
      <<-code.gsub(/^\s+/, '')
        # def #{children_name}
        #   #{child_model}.where(#{parent_name}_id: self.id)
        # end
      code
    end

    def self.has_one(association)
      params = params association
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

    private

    def self.params association
      association.delete "=>"
      association.map! { |e| e.delete(':').delete(',').downcase }

      params = {}
      params[:model]        = association.shift
      params[:association]  = association.shift
      params[:associate]    = association.shift

      params.merge!(Hash[*association]).symbolize_keys!
    end
  end
end
