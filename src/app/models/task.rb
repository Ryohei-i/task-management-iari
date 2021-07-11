class Task < ApplicationRecord
  validates :name, presence: true
  validates :start_time, presence: true

  belongs_to :user
end
