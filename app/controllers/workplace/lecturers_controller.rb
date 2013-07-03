# encoding: utf-8

require 'importers/csv_import'

class Workplace::LecturersController < Workplace::WorkplaceController
  inherit_resources

  actions :all, except: [:show, :index]

  custom_actions :collection => :import

  belongs_to :organization

  def import
    import! {
      file = params[:import][:file] if params[:import]

      begin
        CsvImport.new(file.tempfile.path, collection.new).import
        flash[:notice] = 'Импорт прошел успешно'
      rescue
        flash[:alert] = 'Во время импорта произошла ошибка'
      end

      redirect_to parent_path and return
    }
  end
end
