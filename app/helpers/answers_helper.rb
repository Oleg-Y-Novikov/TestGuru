# frozen_string_literal: true

module AnswersHelper
  # Возвращает корректный заголовок в зависимости от состояния объекта
  def answer_header
    if @answer.new_record?
      t('.create_new_answer')
    else
      t('.edit_answer')
    end
  end
end
