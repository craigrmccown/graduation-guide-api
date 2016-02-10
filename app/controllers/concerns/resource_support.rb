module ResourceSupport
  extend ActiveSupport::Concern

  def load_resource(model=nil)
    if model.nil?
      model = params[:controller]
      id = params[:id]
    else
      id = params["#{model}_id".to_sym]
    end
    
    resource = current_user.send("#{model.to_s.pluralize}").find_by(id: id)
    raise NotFoundError, "cannot find #{model} with id #{id}" if resource.nil?
    instance_variable_set("@#{model.to_s}", resource)
  end
end
