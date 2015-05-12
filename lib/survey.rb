class Survey < ActiveRecord::Base
  has_and_belongs_to_many(:questions)
  before_validation :normalize_name, on: :create

  private
    def normalize_name
      self.name = self.name.downcase.titleize
    end

end
