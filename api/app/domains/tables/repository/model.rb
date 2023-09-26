module Tables
  module Repository
    class Model < ApplicationRecord
      self.table_name = 'tables'
    end
  end
end
