# frozen_string_literal: true

module Decidim
  module Surveys
    # The data store for a Survey in the Decidim::Surveys component.
    class Survey < Surveys::ApplicationRecord
      include Decidim::Resourceable
      include Decidim::Forms::HasQuestionnaire
      include Decidim::HasComponent

      component_manifest_name "surveys"

      validates :questionnaire, presence: true

      # Returns if the survey can be cleaned (ie: all answers destroyed!)
      # after the component is published
      #
      # TODO!!!
      #
      # a possible implementation would be to add a boolean or timestamp in the database
      def clean_after_publish?
        true
      end
    end
  end
end
