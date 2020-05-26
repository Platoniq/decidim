# frozen_string_literal: true

module Decidim
  module Admin
    # Controller that allows managing questionnaire templates at the admin panel.
    #
    class QuestionnaireTemplatesController < Admin::ApplicationController
      helper_method :questionnaire_template

      def index
        enforce_permission_to :read, :questionnaire_template
        @questionnaire_templates = collection.page(params[:page]).per(15)
      end

      def new
        enforce_permission_to :create, :questionnaire_template
        @form = form(QuestionnaireTemplateForm).instance
      end

      def create
        enforce_permission_to :create, :questionnaire_template

        @form = form(QuestionnaireTemplateForm).from_params(params)

        CreateQuestionnaireTemplate.call(@form) do
          on(:ok) do
            flash[:notice] = I18n.t("questionnaire_templates.create.success", scope: "decidim.admin")
            redirect_to action: :index
          end

          on(:invalid) do
            flash.now[:alert] = I18n.t("questionnaire_templates.create.error", scope: "decidim.admin")
            render :new
          end
        end
      end

      def duplicate
        @questionnaire_template = collection.find(params[:id])

        enforce_permission_to :create, :questionnaire_template

        DuplicateQuestionnaireTemplate.call(@questionnaire_template) do
          on(:ok) do
            flash[:notice] = I18n.t("questionnaire_templates.duplicate.success", scope: "decidim.admin")
            redirect_to action: :index
          end

          on(:invalid) do
            flash.now[:alert] = I18n.t("questionnaire_templates.duplicate.error", scope: "decidim.admin")
            render :index
          end
        end
      end

      def edit
        @questionnaire_template = collection.find(params[:id])
        enforce_permission_to :update, :questionnaire_template, questionnaire_template: @questionnaire_template
        @form = form(QuestionnaireTemplateForm).from_model(@questionnaire_template)
      end

      def update
        @questionnaire_template = collection.find(params[:id])
        enforce_permission_to :update, :questionnaire_template, questionnaire_template: @questionnaire_template
        @form = form(QuestionnaireTemplateForm).from_params(params)

        UpdateQuestionnaireTemplate.call(@questionnaire_template, @form, current_user) do
          on(:ok) do |_template|
            flash[:notice] = I18n.t("questionnaire_templates.update.success", scope: "decidim.admin")
            redirect_to action: :index
          end

          on(:invalid) do |template|
            @questionnaire_template = template
            flash.now[:error] = I18n.t("questionnaire_templates.update.error", scope: "decidim.admin")
            render action: :edit
          end
        end
      end

      def destroy
        @questionnaire_template = collection.find(params[:id])
        enforce_permission_to :destroy, :questionnaire_template, questionnaire_template: @questionnaire_template

        DestroyQuestionnaireTemplate.call(@questionnaire_template, current_user) do
          on(:ok) do
            flash[:notice] = I18n.t("questionnaire_templates.destroy.success", scope: "decidim.admin")
            redirect_to action: :index
          end

          on(:invalid) do
            flash.now[:error] = I18n.t("questionnaire_templates.destroy.error", scope: "decidim.admin")
            redirect_to :back
          end
        end
      end

      def preview
        @questionnaire_template = collection.find(params[:id])
        enforce_permission_to :preview, :questionnaire_template, questionnaire_template: @questionnaire_template

        @form = form(Decidim::Forms::QuestionnaireForm).from_model(@questionnaire_template.questionnaire)

        render "decidim/forms/questionnaires/show"
      end

      private

      def collection
        @collection ||= current_organization.questionnaire_templates
      end

      def questionnaire_template
        @questionnaire_template ||= QuestionnaireTemplate.find(params[:id])
      end
    end
  end
end
