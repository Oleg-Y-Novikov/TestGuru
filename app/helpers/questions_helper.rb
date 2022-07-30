module QuestionsHelper
  # Возвращает корректный заголовок в зависимости от состояния объекта
  def question_header(test_title)
    if @question.new_record?
      t('page_questions.create_new_question', test_title: test_title)
    else
      t('page_questions.edit_question', test_title: test_title)
    end
  end
end
