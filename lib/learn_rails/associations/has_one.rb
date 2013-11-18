module LearnRails
  class Associations::HasOne < Associations
    def self.code_for(params)
      associate_model = (params[:class_name] || params[:associate]).camelize
      foreign_id      = params[:foreign_key] || params[:model] + "_id"
      primary_id      = params[:primary_key] || "id"

      <<-code.gsub(/^\s+/, '')
        # def #{params[:associate]}(force_reload = false)
        #   @#{params[:associate]} = nil if force_reload
        #   @#{params[:associate]} ||= #{associate_model}.find_by_#{foreign_id}(self.#{primary_id})
        # end
        #{ setter_method(params, foreign_id, primary_id) unless params[:readonly] }
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

    private

    def self.setter_method params, foreign_id, primary_id
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
