class RecordsController < ApplicationController
  before_action :require_login

  def index
    @records_by_date = current_user.records.group_by { |record| record.created_at.to_date }
  end

  def search
    @items_search = Item.ransack(title_name_or_artist_name_name_cont: params[:q], user_id_eq: current_user.id)
    @items = @items_search.result.includes(:title, :artist_name)
  
    items_json = @items.as_json(include: [:title, :artist_name])
    render json: items_json
  end

  def new
    @record = Record.new
  end

  def create
    @record = current_user.records.build(record_params)
    if @record.save
      redirect_to records_path, notice: t('records.new.saved')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update; end

  def show
    @record = Record.find(params[:id])
  end

  def daily_records
    date = Date.parse(params[:date])
    @records = current_user.records.where('DATE(created_at) = ?', date)
  end

  def destroy; end

  private

  def record_params
    params.require(:record).permit(:content, item_ids: [])
  end
end
