# frozen_string_literal: true

module Decidim
  class QuestionnaireTemplate < ApplicationRecord
    include Decidim::Traceable
    include Decidim::Loggable
    include Decidim::Forms::HasQuestionnaire

    belongs_to :organization, foreign_key: "decidim_organization_id", class_name: "Decidim::Organization", inverse_of: :questionnaire_templates

    validates :title, :organization, presence: true

    def owner
      organization
    end

    def type
      "Decidim::QuestionnaireTemplate"
    end

    def self.log_presenter_class_for(_log)
      Decidim::AdminLog::QuestionnaireTemplatePresenter
    end
  end
end
