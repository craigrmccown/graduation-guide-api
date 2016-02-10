module JsonSupport
  extend ActiveSupport::Concern

  class_methods do
    attr_reader :json_excluded, :json_transients

    def json_exclude(*attrs)
      @json_excluded ||= []
      attrs.each { |attr| @json_excluded.push attr }
    end

    def json_transient(*attrs)
      @json_transients ||= []
      attrs.each { |attr| @json_transients.push attr }
    end
  end

  def as_json(options={})
    keys_to_camel super(options)
  end

  private

  def keys_to_camel(hash)
    unless self.class.json_excluded.nil?
      self.class.json_excluded.each do |e|
        hash.delete e.to_s
      end
    end

    unless self.class.json_transients.nil?
      self.class.json_transients.each do |t|
        hash[t.to_s] = send t.to_s
      end
    end

    values = hash.map do |key, value|
      [key.camelize(:lower), value]
    end
    Hash[values]
  end
end
