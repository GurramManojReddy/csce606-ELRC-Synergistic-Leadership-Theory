# frozen_string_literal: true

require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the SurveyResponsesHelper. For example:
#
# describe SurveyResponsesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end

# rubocop:disable Metrics/BlockLength

RSpec.describe SurveyResponsesHelper, type: :helper do
  # create other models necessary for testing survey_responses_helper

  let(:survey_answer) do
    SurveyAnswer.create!(
      choice: 3,
      question_id: 1,
      response_id: 1
    )
  end
  let(:survey_profile) do
    SurveyProfile.create!(
      user_id: 1,
      first_name: 'John',
      last_name: 'Doe',
      campus_name: 'Main',
      district_name: 'District',
      role: 'Teacher'
    )
  end

  let(:survey_response) do
    SurveyResponse.create!(
      profile_id: survey_profile.id,
      share_code: 'debug7'
    )
  end

  let(:survey_question) do
    SurveyQuestion.create!(
      text: 'Question',
      section: 1
    )
  end

  

  describe '#average_score' do
    it 'returns the average score of a survey response' do
      # returns average score of the survey response answers
      expect(helper.average_score(survey_response)).to eq(survey_response.answers.average(:choice).to_f)
    end
  end


  describe '#formatted_date' do
    it 'returns the formatted date of a survey response' do
      expect(helper.formatted_date(survey_response)).to eq(survey_response.created_at.strftime('%B %d, %Y'))
    end
  end

  describe '#user_of_response' do
    it 'returns the user of a survey response' do
      expect(helper.user_of_response(survey_response)).to eq(survey_response.profile_id)
    end
  end

  describe '#average_score' do
    it 'returns the average score of survey responses of teachers' do
      # returns average score of the survey response answers
      survey_questions = survey_response.answers
      expect(helper.average_of_teachers(survey_response)).to eq(survey_questions.length)
    end
  end
end

# rubocop:enable Metrics/BlockLength
