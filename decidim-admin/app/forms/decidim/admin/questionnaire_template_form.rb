# frozen_string_literal: true

module Decidim
  module Admin
    # The form that validates the data to construct a valid QuestionnaireTemplate.
    class QuestionnaireTemplateForm < Form
      include TranslatableAttributes

      translatable_attribute :title, String
      translatable_attribute :description, String

      validates :title, translatable_presence: true
    end
  end
end
