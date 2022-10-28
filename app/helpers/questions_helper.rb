module QuestionsHelper
  # Возвращает корректный заголовок в зависимости от состояния объекта
  def question_header(test_title)
    if @question.new_record?
      t('.create_new_question', test_title: test_title)
    else
      t('.edit_question', test_title: test_title)
    end
  end
end
