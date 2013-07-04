class Timetable < ActiveRecord::Base
  extend Enumerize

  attr_accessible :ends_on, :parity, :starts_on, :status, :title, :first_week_parity

  belongs_to :organization

  has_many :lesson_times, :as => :context, :dependent => :destroy, :order => 'day ASC, number ASC'
  has_many :weeks, dependent: :destroy, :order => 'number ASC'

  validates_presence_of :title, :starts_on, :ends_on

  after_create :create_weeks
  after_create :create_lesson_times

  enumerize :status, in: [:draft, :published], predicates: true

  private

  def create_weeks
    number = 1
    week_parity = self.first_week_parity
    (self.starts_on.beginning_of_week..self.ends_on).each_slice(7) do |days|
      if self.parity?
        if week_parity % 2 == 0
          week = weeks.create(:number => number, :starts_on => days.first > starts_on ? days.first : starts_on, :parity => :even)
        else
          week = weeks.create(:number => number, :starts_on => days.first > starts_on ? days.first : starts_on, :parity => :odd)
        end
      else
        week = weeks.create(:number => number, :starts_on => days.first > starts_on ? days.first : starts_on)
      end
      number += 1
      week_parity += 1 if self.first_week_parity?
      days.each do |day|
        week.days.create(date: day)
      end
    end
  end

  def create_lesson_times
    (1..6).each do |day|
      (1..6).each do |number|
        lesson_times.create :day => day, :number => number, :starts_at => '0:00', :ends_at => '0:00'
      end
    end
  end
end