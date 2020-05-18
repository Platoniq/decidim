# frozen_string_literal: true

module Decidim
  module Admin
    # The form that validates the data to construct a valid OAuthApplication.
    class QuestionnaireTemplateForm < Decidim::Form
      include TranslatableAttributes

      translatable_attribute :title, String
      translatable_attribute :description, String

      mimic :questionnaire_template

      validates :title, :description, translatable_presence: true
    end
  end
end
