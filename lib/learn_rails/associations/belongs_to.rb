module LearnRails
  class Associations::BelongsTo < Associations
    def self.code_for(params)
      associate_model = (params[:class_name] || params[:associate]).camelize
      foreign_id      = params[:foreign_key] || params[:associate] + "_id"
      primary_id      = params[:primary_key] || "id"

      <<-code.gsub(/^\s+/, '')
        # def #{params[:associate]}
        #   #{associate_model}.find_by_id(self.#{foreign_id})
        # end
        #{ setter_method(params, foreign_id, primary_id) unless params[:readonly] }
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

    private

    def self.setter_method params, foreign_id, primary_id
      <<-code.gsub(/^\s+/, '')
          #
          # def #{params[:associate]}=(#{params[:associate]})
          #   self.#{foreign_id} = #{params[:associate]}.#{primary_id}
          # end
      code
    end


    def self.getter_method params
      <<-code.gsub(/^\s+/, '')
          # def #{params[:associate]}
          #   #{associate_model}.find_by_id(self.#{foreign_id})
          # end
      code
    end
  end
end