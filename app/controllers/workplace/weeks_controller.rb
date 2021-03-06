# encoding: utf-8

class Workplace::WeeksController < Workplace::WorkplaceController
  inherit_resources

  actions :all, except: [:index, :new, :edit]

  custom_actions :resource => :pdf

  belongs_to :timetable

  def show
    show! {
      @weeks = @timetable.weeks
      pdf_week = Pdf::Week.new(@week)
      @table = pdf_week.table_data
      pdf_week.set_colspans(@table)
    }
  end

  def pdf
    pdf! {
      send_data Pdf::Week.new(@week).render, :type => 'application/pdf', :filename => 'week.pdf', :disposition => :inline and return
    }
  end

  protected

  def begin_of_association_chain
    @organization
  end
end
