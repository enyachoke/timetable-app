class Manage::TariffsController < Manage::ManageController
  def edit
    @tariff = resource
  end

  def update
    begin
      @tariff = resource
      @tariff.attributes = params['tariff']
      @tariff.save!
      flash[:notice] = 'Тариф успешно сохранен'
      redirect_to manage_root_path
    rescue => e
      logger.error "ERROR: #{e}"
      flash[:alert] = 'Во время сохранения произошла ошибка'
      render :edit
    end
  end

private
  def resource
    Tariff.instance
  end
end
