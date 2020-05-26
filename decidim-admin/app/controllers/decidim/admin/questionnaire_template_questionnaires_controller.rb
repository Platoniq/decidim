# frozen_string_literal: true

module Decidim
  module Admin
    # This controller allows an admin to manage a questionnaire form for a questionnaire_template
    class QuestionnaireTemplateQuestionnairesController < Admin::ApplicationController
      include Decidim::Forms::Admin::Concerns::HasQuestionnaire

      helper Decidim::Admin::ExportsHelper

      def questionnaire_for
        questionnaire_template
      end

      def update_url
        questionnaire_template_questionnaire_path(questionnaire_template_id: questionnaire_template.id)
      end

      def after_update_url
        edit_questionnaire_template_path(id: questionnaire_template.id)
      end

      private

      def questionnaire_template
        @questionnaire_template ||= QuestionnaireTemplate.find(params[:questionnaire_template_id])
      end
    end
  end
end
