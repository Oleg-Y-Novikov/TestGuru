# frozen_string_literal: true

class GistQuestionService

  def initialize(question, client: nil)
    @question = question
    @test = question.test
    @client = client || GitHubOctokitClient.new
  end

  def create_github_gist
    @result = @client.create_gist(gist_params)
    return if @result.blank?

    @result
  end

  def save_gist(current_user, current_question)
    Gist.create(
      user: current_user,
      gist_id: @result.id,
      gist_url: @result.html_url,
      question: current_question
    )
  end

  private

  def gist_params
    {
      description: I18n.t('services.gist_question.gist_params.description', test_title: @test.title),
      files: {
        'test-guru-question.txt' => {
          content: gist_content
        }
      }
    }
  end

  def gist_content
    content = [@question.body]
    content += @question.answers.pluck(:body)
    content.join("\n")
  end
end
