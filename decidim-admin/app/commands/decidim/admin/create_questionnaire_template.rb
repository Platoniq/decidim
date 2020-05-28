# frozen_string_literal: true

module Decidim
  module Admin
    # Creates an QuestionnaireTemplate.
    class CreateQuestionnaireTemplate < Rectify::Command
      # Initializes the command.
      #
      # form - The source fo data for this QuestionnaireTemplate.
      def initialize(form)
        @form = form
      end

      def call
        return broadcast(:invalid) unless @form.valid?

        @application = Decidim.traceability.create!(
          QuestionnaireTemplate,
          @form.current_user,
          title: @form.title,
          description: @form.description,
          organization: @form.current_organization,
          questionnaire: Decidim::Forms::Questionnaire.new(title: @form.title)
        )

        broadcast(:ok, @application)
      end
    end
  end
end
