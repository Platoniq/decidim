# frozen_string_literal: true

module Decidim
  # Controller that allows previewing questionnaire templates
  #
  class QuestionnaireTemplatePreviewsController < ApplicationController
    def show
      redirect_to dummy_survey_path
    end

    private

    def questionnaire_template
      @questionnaire_template ||= QuestionnaireTemplate.find_by(id: params[:id])
    end

    def dummy_translated
      @dummy_translated ||= I18n.available_locales.map { |locale| [locale, "dummy"] }.to_h
    end

    def dummy_participatory_space
      @dummy_participatory_space ||= Decidim::ParticipatoryProcess.find_or_create_by(slug: "dummy") do |participatory_process|
        participatory_process.hashtag = "dummy"
        participatory_process.organization = current_organization
        participatory_process.title = dummy_translated
        participatory_process.subtitle = dummy_translated
        participatory_process.short_description = dummy_translated
        participatory_process.description = dummy_translated
        participatory_process.promoted = false
        participatory_process.developer_group = dummy_translated
        participatory_process.end_date = 10.years.from_now
        participatory_process.meta_scope = dummy_translated
        participatory_process.local_area = dummy_translated
        participatory_process.target = dummy_translated
        participatory_process.participatory_scope = dummy_translated
        participatory_process.participatory_structure = dummy_translated
        participatory_process.show_statistics = false
        participatory_process.announcement = nil
        participatory_process.scopes_enabled = false
        participatory_process.start_date = 1.day.ago
        participatory_process.private_space = true
        participatory_process.reference = "DUMMY"
        participatory_process.show_metrics = false
      end
    end

    def dummy_surveys_component
      @dummy_surveys_component ||= Decidim::Component.find_or_create_by(manifest_name: "surveys", participatory_space: dummy_participatory_space) do |component|
        component.manifest_name = "surveys"
        component.name = dummy_translated
        component.participatory_space = dummy_participatory_space
        component.settings = {
          allow_answers: true,
          allow_unregistered: true
        }
        component.published_at = 1.day.ago
      end
    end

    def dummy_survey(questionnaire)
      if @dummy_survey.present? && @dummy_survey.questionnaire.id == questionnaire.id
        @dummy_survey
      else
        @dummy_survey = Decidim::Surveys::Survey.create(
          title: dummy_translated,
          description: dummy_translated,
          tos: dummy_translated,
          component: dummy_surveys_component,
          questionnaire: questionnaire
        )
      end
    end

    def dummy_survey_path
      survey = dummy_survey(questionnaire_template.questionnaire)
      EngineRouter.main_proxy(survey.component).root_path(locale: params[:locale])
    end
  end
end
