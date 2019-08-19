class Post < ApplicationRecord

  belongs_to :user
  has_one_attached :image


  enum duration: [:in_two_days, :in_three_days, :in_five_days, :in_seven_days,  :in_two_weeks, :in_a_month, :in_three_months, :in_six_months, :in_a_year, :over_a_year]

end
