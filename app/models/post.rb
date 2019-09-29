class Post < ApplicationRecord

  belongs_to :user
  has_one_attached :image
  has_many :likes
  has_many :liked_users, through: :likes, source: :user

  scope :recent, -> { order("created_at DESC")}

  enum duration: [:in_two_days, :in_three_days, :in_five_days, :in_seven_days,  :in_two_weeks, :in_a_month, :in_three_months, :in_six_months, :in_a_year, :over_a_year]

  validates :image, presence: true
  validates :text, {presence: true, length: {maximum: 10000}}
  validates :country, presence: true
  validates :duration, presence: true



  def like?(user)
    liked_users.include?(user)
  end

end
