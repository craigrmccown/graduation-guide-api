module ParamsSupport
  extend ActiveSupport::Concern

  def permit(*permitted)
    data = params.require(params[:controller]).permit(*permitted)
    instance_variable_set("@#{params[:controller].to_s}_data", data)
  end

  def required(*required)
    required.each do |r|
      params.require(r)
    end
  end
end
