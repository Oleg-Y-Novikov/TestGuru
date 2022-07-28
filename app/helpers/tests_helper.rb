module TestsHelper
  # Возвращает корректный заголовок в зависимости от экшена
  def test_header
    if ApplicationHelper::ACTION.include? action_name
      t('page_tests.create_new_test')
    else
      t('page_tests.edit_test')
    end
  end
end
