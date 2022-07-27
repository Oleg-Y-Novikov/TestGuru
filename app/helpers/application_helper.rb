module ApplicationHelper
  # Возвращает полный заголовок на основе заголовка страницы.
  def full_title(page_title = '')
    base_title = 'TestGuru'
    page_title.blank? ? base_title : "#{page_title} | #{base_title}"
  end

  # Возвращает текущий год.
  def current_year
    Date.today.year
  end

  # Возвращает url на GitHub репозиторий
  def github_url(author, repo)
    %(https://github.com/#{author}/#{repo}/)
  end
end
