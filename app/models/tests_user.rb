# frozen_string_literal: true

class TestsUser < ApplicationRecord
  belongs_to :test
  belongs_to :user
  belongs_to :current_question, class_name: 'Question'

  before_validation :before_validation_set_question, on: %i[create update]

  # увеличивает счетчик верных ответов и обновляет объект TestsUser
  def accept!(answer_ids)
    self.correct_questions += 1 if correct_answer?(answer_ids)

    save!
  end

  # возвращает true если тест пройден до конца в противном случае false
  def completed?
    completed
  end

  # обновляет поля у объекта TestsUser на стартовые значения для прохождения теста
  # метод формирует прямой запрос в базу минуя валидации и колбэки
  def start_test_user_params!
    update_columns(completed: false, correct_questions: 0)
  end

  # возвращает true если тест пройден успешно
  # количество верно данных ответов >= 85%
  def test_passage_success?
    result >= 85
  end

  # возвращает результат прохождения Теста в процентном выражении
  def result
    (correct_questions * 100.0 / test.questions.count).floor(1)
  end

  # возвращает порядковый номер вопроса
  def current_question_number
    test.questions.order(:id).where('id < ?', current_question.id).size + 1
  end

  # возвращает общее колличество вопросов текущего теста
  def total_amount_questions
    test.questions.count
  end

  private

  # проверяет корректность данных пользователем ответов
  # возвращает true если все ответы верные, в противном случае false
  def correct_answer?(answer_ids)
    correct_answers.ids.sort == answer_ids.to_a.map(&:to_i).sort
  end

  # возвращает объект ActiveRecord корректных ответов на текущий вопрос
  def correct_answers
    current_question.answers.correct
  end

  # устанавливает первый вопрос к тесту в поле current_question при первом прохождении теста текущим пользователем
  def before_validation_set_question
    if new_record?
      self.current_question = test.questions.order(:id).first
    else
      self.current_question = test.questions.where('id > ?', current_question).order(:id).first
      return if current_question.present?

      test_completed
    end
  end

  def test_completed
    self.completed = true
    self.current_question = test.questions.order(:id).first
  end
end
