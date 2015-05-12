class Survey < ActiveRecord::Base
  has_many(:questions)
  before_validation :normalize_name, on: :create

  private
    def normalize_name
      self.name = self.name.downcase.titleize
    end

end
