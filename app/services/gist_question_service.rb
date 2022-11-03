# frozen_string_literal: true

class GistQuestionService

  def initialize(question, current_user, client: default_client)
    @question = question
    @current_user = current_user
    @test = question.test
    @client = client
    @errors = {}
  end

  def create_github_gist
    begin
      @result = @client.create_gist(gist_params)
      # ловлю ошибку если GITHUB_ACCESS_TOKEN не действителен или GitHub не отвечает
    rescue Octokit::Unauthorized
      @errors[:github_access_token] = I18n.t('services.gist_question.github_access_token.invalid')
    rescue Faraday::TimeoutError
      @errors[:github_not_available] = I18n.t('services.gist_question.github_not_available')
    end
    responce
  end

  def save_gist
    Gist.create(
      user: @current_user,
      gist_id: @result.id,
      gist_url: @result.html_url,
      question: @question
    )
  end

  private

  def responce
    if @errors.blank?
      { status: :success, result: @result, gist: save_gist, errors: @errors }
    else
      { status: :failure, errors: @errors }
    end
  end

  def default_client
    Octokit.connection_options = { request: { open_timeout: 5, timeout: 5 } }
    begin
      Octokit::Client.new(access_token: ENV.fetch('GITHUB_ACCESS_TOKEN'))
    rescue KeyError
      @errors[:token_not_found] = t('services.gist_question.github_access_token.not_found')
    end
  end

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
    [@question.body, *@question.answers.pluck(:body)].join("\n")
  end
end
