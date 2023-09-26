class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  self.implicit_order_column = :created_at

  class << self
    def primary_key=(pkey)
      @primary_key ||= pkey
    end

    def primary_key
      @primary_key || :id
    end
  end
end
