# frozen_string_literal: true

module ApplicationHelper
  FLASH_TYPE = { notice: :info, alert: :danger }.freeze
  # Возвращает полный заголовок на основе заголовка страницы.
  def full_title(page_title = '')
    base_title = 'TestGuru'
    page_title.blank? ? base_title : "#{page_title} | #{base_title}"
  end

  # Возвращает текущий год.
  def current_year
    Date.current.year
  end

  # Возвращает url на GitHub репозиторий
  def github_url(author:, repo:, title:)
    link_to title, %(https://github.com/#{author}/#{repo}/), target: '_blank', rel: 'nofollow'
  end

  # Возвращает url на страницу VK
  def author_url(author:, title:)
    link_to title, %(https://vk.com/#{author}/), target: '_blank', rel: 'nofollow'
  end

  # Возвращает корректоное название кнопки в зависимости от состояния объекта
  def correct_button_title(object:)
    object.new_record? ? t('global.create') : t('global.edit')
  end

  def flash_message(message_type:)
    return if flash[message_type].blank?

    content_tag(:div, flash[message_type], class: "alert alert-#{FLASH_TYPE[message_type] || message_type}")
  end

  def correct_root_path
    return root_path if current_user.blank?

    current_user.admin? ? admin_tests_path : root_path
  end
end
