module LearnRails
  class Associations::HasMany < Associations
    def self.code_for(params)
      associate_model = params[:associate].singularize.camelize

      <<-code.gsub(/^\s+/, '')
        # def #{params[:associate]}
        #   #{associate_model}.where(#{params[:model]}_id: self.id)
        # end
      code
    end
  end
end
