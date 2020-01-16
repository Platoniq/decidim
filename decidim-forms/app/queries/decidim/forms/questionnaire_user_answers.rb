# frozen_string_literal: true

module Decidim
  module Forms
    # A class used to collect user answers for a questionnaire
    class QuestionnaireUserAnswers < Rectify::Query
      # Syntactic sugar to initialize the class and return the queried objects.
      #
      # questionnaire - a Questionnaire object
      def self.for(questionnaire)
        new(questionnaire).query
      end

      # Initializes the class.
      #
      # questionnaire = a Questionnaire object
      def initialize(questionnaire)
        @questionnaire = questionnaire
      end

      # Returns query with all questionnaire answers
      def query
        Answer.where(questionnaire: @questionnaire)
      end

      # Finds and group answers by user for each questionnaire's question.
      def grouped_by_user
        query.sort_by { |answer| answer.question.position }.group_by { |a| a.user || a.session_token }.values
      end
    end
  end
end
