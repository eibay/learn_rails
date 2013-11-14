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
      parent_name = association[0].downcase
      child_name  = association[2].delete(':').delete(',').downcase
      child_model = child_model(association)
      <<-code.gsub(/^\s+/, '')
        # def #{child_name}(force_reload = false)
        #   @#{child_name} = nil if force_reload
        #   @#{child_name} ||= #{child_model}.find_by_#{parent_name}_id(self.id)
        # end
        #
        # def #{child_name}=(#{child_name})
        #   #{child_name}.#{parent_name}_id = self.id
        #   #{child_name}.save
        # end
        #
        # def build_#{child_name}(attributes = {})
        #   attributes[:#{parent_name}_id] = self.id
        #   #{child_model}.new(attributes)
        # end
        #
        # def create_#{child_name}(attributes = {})
        #   attributes[:#{parent_name}_id] = self.id
        #   #{child_model}.create(attributes)
        # end
        #
        # def create_#{child_name}!(attributes = {})
        #   attributes[:#{parent_name}_id] = self.id
        #   #{child_model}.create!(attributes)
        # end
      code
    end

    private

    def self.child_model association
      model_element = case association[3]
      when ":class_name"
        association[5]
      when "class_name:"
        association[4]
      else
        association[2]
      end

      model_element.delete(':').delete(',').downcase.camelize
    end
  end
end
