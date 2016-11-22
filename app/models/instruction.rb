class Instruction < ApplicationRecord
  belongs_to :recipe, optional: true
end
