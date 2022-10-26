# frozen_string_literal: true

class TestsMailer < ApplicationMailer
  def completed_test(test_user)
    @user = test_user.user
    @test = test_user.test

    mail to: @user.email  # subject: I18n.t('tests_mailer.completed_test.subject')
  end
end
