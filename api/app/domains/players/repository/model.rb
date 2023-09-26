module Players
  module Repository
    class Model < ApplicationRecord
      self.table_name = 'players'
    end
  end
end
