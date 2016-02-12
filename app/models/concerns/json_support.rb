module JsonSupport
  extend ActiveSupport::Concern

  class_methods do
    def json_excluded
      @json_excluded ||= []
    end

    def json_exclude(*attrs)
      @json_excluded = attrs
    end

    def json_transients
      @json_transients ||= []
    end

    def json_transient(*attrs)
      @json_transients = attrs
    end

    def json_nested
      @json_nested ||= []
    end

    def json_nest(*attrs)
      @json_nested = attrs
    end
  end

  def serializable_hash(options={})
    options[:include] ||= self.class.json_nested
    keys_to_camel super(options)
  end

  private

  def keys_to_camel(hash)
    self.class.json_excluded.each do |e|
      hash.delete e.to_s
    end

    self.class.json_transients.each do |t|
      hash[t.to_s] = send t.to_s
    end

    values = hash.map do |key, value|
      [key.camelize(:lower), value]
    end

    Hash[values]
  end
end
