module TestsHelper
  # Возвращает корректный заголовок в зависимости от состояния объекта
  def test_header
    if @test.new_record?
      t('page_tests.create_new_test')
    else
      t('page_tests.edit_test')
    end
  end
end
