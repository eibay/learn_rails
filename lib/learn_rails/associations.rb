module LearnRails
  class Associations
    def self.belongs_to(association)
      parent_name   = association.split[2].delete ':'
      parent_model  = parent_name.capitalize
      <<-code.strip_heredoc
        # def #{parent_name}
        #   #{parent_model}.find_by_id(self.#{parent_name}_id)
        # end
      code
    end

    def self.has_many(association)
      parent_name   = association.split[0].downcase
      children_name = association.split[2].delete(':').downcase
      child_model   = children_name.singularize.capitalize
      <<-code.strip_heredoc
        # def #{children_name}
        #   #{child_model}.where(#{parent_name}_id: self.id)
        # end
      code
    end

    def self.has_one(association)
      parent_name = association.split[0].downcase
      child_name  = association.split[2].delete(':').downcase
      child_model = child_name.capitalize
      <<-code.strip_heredoc
        # def #{child_name}
        #   #{child_model}.find_by_#{parent_name}_id(self.id)
        # end
      code
    end
  end
end
