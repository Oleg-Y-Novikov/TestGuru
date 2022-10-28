# frozen_string_literal: true

module TestsHelper
  # Возвращает корректный заголовок в зависимости от состояния объекта
  def test_header
    if @test.new_record?
      t('.create_new_test')
    else
      t('.edit_test')
    end
  end

  def current_user_test_completed?(test)
    test.completed.to_i == 1
  end
end
