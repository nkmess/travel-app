class Post < ApplicationRecord

  belongs_to :user
  has_one_attached :image
  has_many :likes
  has_many :liked_users, through: :likes, source: :user

  scope :recent, -> { order("created_at DESC")}

  scope :europe, -> { where(country: ["208", "250", "528", "578", "643", "724", "752", "826"]) }
  scope :africa, -> { where(country: ["710, 818"]) }
  scope :north_america, -> { where(country: ["124", "840"]) }
  scope :latain_america, -> { where(country: ["032","076", "152"]) }
  scope :asia, -> { where(country: ["156", "158", "344", "392", "410", "702", "764"]) }
  scope :oceania, -> { where(country: ["036", "316",  "554"]) }
  scope :middle_east, -> { where(country: ["682", "792"]) }


  enum duration: [:in_two_days, :in_three_days, :in_five_days, :in_seven_days,  :in_two_weeks, :in_a_month, :in_three_months, :in_six_months, :in_a_year, :over_a_year]

  validates :image, presence: true
  validates :text, {presence: true, length: {maximum: 10000}}
  validates :country, presence: true
  validates :duration, presence: true



  def like?(user)
    liked_users.include?(user)
  end

end
