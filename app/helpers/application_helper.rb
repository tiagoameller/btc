module ApplicationHelper
  include ActionView::Helpers::NumberHelper
  def present(model, presenter_class = nil)
    klass = presenter_class || "#{model.class}Presenter".constantize
    presenter = klass.new(model, self)
    yield(presenter) if block_given?
  end

  def format_date(date)
    date.present? ? I18n.l(date, format: '%a, %0d/%0m/%Y') : I18n.t('common.undefined')
  end

  def format_relative_date_time(date, date_time)
    if date == date_time.to_date
      format_time(date_time)
    else
      format_date_time(date_time)
    end
  end

  def format_time(time)
    time.present? ? I18n.l(time, format: '%H:%M') : I18n.t('common.undefined')
  end

  def format_date_time_for_sort(date_time)
    date_time.present? ? I18n.l(date_time, format: '%Y%0m%0d%H%M%S') : 99_999_999_999_999
  end

  def format_date_time(date_time)
    date_time.present? ? I18n.l(date_time, format: '%0d/%0m/%Y %H:%M') : I18n.t('common.undefined')
  end

  def safe_time_ago_in_words(date_time)
    date_time.present? ? time_ago_in_words(date_time) : I18n.t('common.never')
  end

  def bwz(value)
    value if value && value != 0
  end

  def number_to_currency_bwz(value)
    # dash when zero
    value && value != 0 ? number_to_currency(value) : '-'
  end

  def number_to_currency_no_unit(value)
    # "123.456,70"
    number_to_currency(value, format: '%n')
  end

  def coreui_icon(icon, variant, options = {})
    local_options = options.dup
    html_class = local_options.delete(:class)
    local_options[:class] = "ci#{variant}-#{icon}"
    local_options[:class] += ' ' + html_class if html_class # rubocop:disable Style/StringConcatenation
    tag.i(nil, local_options)
  end

  # lineal
  def coreui_icon_l(icon, options = {})
    coreui_icon(icon, :l, options)
  end

  # brand
  def coreui_icon_b(icon, options = {})
    coreui_icon(icon, :b, options)
  end

  # flag
  def coreui_icon_f(icon, options = {})
    coreui_icon(icon, :f, options)
  end

  def creating?
    %w(new create).include?(action_name)
  end

  def updating?
    %w(edit update).include?(action_name)
  end

  def class_by_action
    if creating?
      'success'
    elsif updating?
      'warning'
    else
      'info'
    end
  end

  def icon_by_model(model, options = {})
    result =
      case model.to_s
      when 'question'
        'search'
      when 'answer'
        'user-female'
      else
        '3d'
      end
    coreui_icon_l(result, options)
  end

  def enum_options_for_select(klass, enum, selected_key = nil)
    options_for_select(
      klass.send(enum.to_s.pluralize).keys.map do |k|
        [t("enums.#{klass.to_s.downcase}.#{enum}.#{k}"), k]
      end,
      selected_key
    )
  end

  def svg_tag(file)
    "app/assets/images/#{file}"
  end

  def svg(icon, css_class: nil)
    tag(:svg, class: "icon icon_#{icon} #{css_class}") do
      tag(:use, nil, 'xlink:href' => "#icon_#{icon}")
    end
  end
end
