module AlertsHelper
  IZITOAST_SETTINGS =
    [
      'class: "mt-4"',
      'position: "topCenter"',
      'displayMode: "1"',
      'layout: "2"',
      'titleSize: "1.4em"',
      'messageSize: "1.1em"',
      'titleLineHeight: "1.4em"'
    ].freeze

  def error_messages(model)
    return unless model.errors.any?

    tag.div(nil, class: 'c-callout c-callout-danger mx-4 mt-2 mb-0') do
      concat(tag.h4(I18n.t('errors.messages.not_saved', count: model.errors.count)))
      model.errors.full_messages.map do |message|
        concat(tag.p(message, class: 'mb-0'))
      end
    end
  end

  def flash_messages(options = { dimissable: true })
    flash.each do |msg_type, message|
      translated = translate_flash_type(msg_type)
      bootstrap_class = translated[:class]
      concat(tag.div(message, class: "alert #{bootstrap_class} #{options[:dimissable] == true ? 'alert-dimissable' : ''} fade show",
                              role: 'alert') do
               if options[:dimissable] == true
                 concat(tag.button(class: 'close', data: { dismiss: 'alert' }, 'aria-label' => 'Close') do
                   concat(tag.span('&times;'.html_safe, 'aria-hidden' => true))
                 end)
               end
               concat(tag.h5 { "#{coreui_icon_l(translated[:icon])} #{translated[:title]}" })
               concat " #{message}"
             end)
    end
    nil
  end

  def toast_messages(options = {})
    # sample of use with options
    # = toast_messages position: '"bottomRight"'
    izitoast_settings = IZITOAST_SETTINGS + options.map { |k, v| "'#{k}': #{v}" }
    result = []
    flash.each do |msg_type, message|
      break unless message

      translated = translate_toast_type(msg_type)
      js_content = <<~STRING
        window.IziToast.settings({ #{izitoast_settings.join(',')} });
        window.IziToast.show({
          title: "#{translated[:title]}",
          message: "#{message}",
          icon: "cil-icon cil-#{translated[:icon]}",
          color: "#{translated[:color]}"
        });
      STRING
      js = javascript_tag(js_content)
      result << js
    end
    result.join(' ').html_safe
  end

  private

  def translate_flash_type(flash_type)
    {
      class: { success: 'alert-success', error: 'alert-danger', alert: 'alert-warning', notice: 'alert-info' }[flash_type.to_sym] || flash_type.to_s,
      title: translate_title(flash_type),
      icon: translate_icon(flash_type)
    }
  end

  def translate_toast_type(toast_type)
    {
      color: { success: '#4dbd74', error: '#f86c6b', alert: '#ffc107', notice: '#63c2de' }[toast_type.to_sym] || toast_type.to_s,
      title: translate_title(toast_type),
      icon: translate_icon(toast_type)
    }
  end

  def translate_icon(icon)
    { success: 'check', error: 'fire', alert: 'bell', notice: 'info' }[icon.to_sym] || icon.to_s
  end

  def translate_title(title)
    { success: I18n.t('flash.success'), error: I18n.t('flash.error'), alert: I18n.t('flash.alert'), notice: I18n.t('flash.notice') }[title.to_sym] || title.to_s
  end
end
