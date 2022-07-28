module QuestionsHelper
  # Возвращает корректный url в зависимости от экшена
  def correct_url
    @test.blank? ? nil : test_questions_path(@test)
  end

  # Возвращает корректный заголовок в зависимости от экшена
  def question_header(test_title)
    if ApplicationHelper::ACTION.include? action_name
      t('page_questions.create_new_question', test_title: test_title)
    else
      t('page_questions.edit_question', test_title: test_title)
    end
  end
end
