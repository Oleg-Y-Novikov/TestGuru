# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/tests_mailer
class TestsMailerPreview < ActionMailer::Preview

  def completed_test
    test_user = TestsUser.new(test: Test.first, user: User.first)

    TestsMailer.completed_test(test_user)
  end
end
