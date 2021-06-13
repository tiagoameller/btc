class ApplicationDatatable
  delegate :params, to: :@view
  delegate :link_to, to: :@view
  delegate :mail_to, to: :@view
  delegate :content_tag, to: :@view
  delegate :present, to: :@view
  delegate :current_company, to: :@view
  delegate :current_user, to: :@view
  delegate :coreui_icon_l, to: :@view
  delegate :distance_of_time_in_words, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(_options = {})
    {
      recordsTotal: count,
      recordsFiltered: total_entries,
      data: data
    }
  end

  private

  def sort_column
    columns[params.dig(:order, '0', :column).to_i]
  end

  def sort_direction
    params.dig(:order, '0', :dir) == 'desc' ? 'desc' : 'asc'
  end

  def page
    params[:start].to_i / per_page + 1
  end

  def per_page
    params[:length].to_i > 0 ? params[:length].to_i : 10
  end
end
