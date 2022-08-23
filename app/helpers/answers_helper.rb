module AnswersHelper
  # Возвращает корректный заголовок в зависимости от состояния объекта
  def answer_header
    if @answer.new_record?
      t('page_answers.create_new_answer')
    else
      t('page_answers.edit_answer')
    end
  end
end
