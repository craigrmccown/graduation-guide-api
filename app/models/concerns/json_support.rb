module JsonSupport
  extend ActiveSupport::Concern

  class_methods do
    def json_excluded
      @json_excluded ||= []
    end

    def json_exclude(*attrs)
      @json_excluded = attrs
    end

    def json_embedded
      @json_embedded ||= []
    end

    def json_embed(*attrs)
      @json_embedded = attrs
    end
  end

  def serializable_hash(options={})
    keys_to_camel super(options)
  end

  private

  def keys_to_camel(hash)
    self.class.json_excluded.each do |e|
      hash.delete e.to_s
    end

    self.class.json_embedded.each do |e|
      hash[e.to_s] = send e.to_s
    end

    values = hash.map do |key, value|
      [key.camelize(:lower), value]
    end

    Hash[values]
  end
end
