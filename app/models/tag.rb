class Tag < ApplicationRecord
  belongs_to :task

  validates :name, presence: true
end
