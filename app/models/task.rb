class Task < ApplicationRecord
  belongs_to :user
  belongs_to :category, optional: true
  has_many :tags, dependent: :destroy

  enum :status, { pending: 0, in_progress: 1, completed: 2 }

  validates :title, presence: true, length: { minimum: 1, maximum: 255 }
  validates :description, length: { maximum: 1000 }, allow_blank: true
  validates :due_date, presence: true
  validate :due_date_cannot_be_in_the_past

  scope :recent, -> { order(created_at: :desc) }
  scope :by_status, ->(status) { where(status: status) }
  scope :due_soon, -> { where('due_date <= ?', 1.day.from_now) }

  private

  def due_date_cannot_be_in_the_past
    return unless due_date.present? && due_date < Time.current

    errors.add(:due_date, "không thể là thời gian trong quá khứ")
  end
end
