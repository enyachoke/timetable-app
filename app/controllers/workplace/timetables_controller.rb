# encoding: utf-8

class Workplace::TimetablesController < Workplace::WorkplaceController
  inherit_resources

  actions :all

  belongs_to :organization, :finder => :find_by_subdomain!

  custom_actions :resource => [:to_draft, :to_published]

  def to_published
    to_published! {
      @timetable = @organization.timetables.find(params[:id])

      begin
        @timetable.publish!
        flash[:notice] = 'Расписание опубликовано.'
      rescue => e
        logger.error "ERROR: #{e}"
        flash[:alert] = 'Вы не можете опубликаовать расписание, вам необходимо расширить вашу подписку.'
      end

      redirect_to workplace_organization_timetable_path(@organization.subdomain, @timetable) and return
    }
  end

  def to_draft
    to_draft! {
      @timetable = @organization.timetables.find(params[:id])

      begin
        @timetable.unpublish!
        flash[:notice] = 'Расписание переведено в состояние черновика.'
      rescue => e
        logger.error "ERROR: #{e}"
        flash[:alert] = 'Расписание уже находится в состоянии черновика.'
      end

      redirect_to workplace_organization_timetable_path(@organization.subdomain, @timetable) and return
    }
  end
end
