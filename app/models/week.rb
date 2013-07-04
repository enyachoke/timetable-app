# encoding: utf-8

class Week < ActiveRecord::Base
  attr_accessible :number, :starts_on, :parity

  belongs_to :timetable

  has_many :days

  extend Enumerize
  enumerize :parity, in: [:odd, :even], predicates: true

  scope :even, -> { where(parity: :even) }
  scope :odd, -> { where(parity: :odd) }

  def to_s
    "неделя #{number}, #{starts_on}"
  end
end