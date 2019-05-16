class Dose < ApplicationRecord
  belongs_to :cocktail
  belongs_to :ingredient
  validates :description, presence: true, allow_blank: false
  validates :ingredient, uniqueness:
  { scope: :cocktail, message: 'should be uniq pair' }
end
