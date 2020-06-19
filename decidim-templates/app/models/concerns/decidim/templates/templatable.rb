# frozen_string_literal: true

require "active_support/concern"

module Decidim
  module Templates
    # A concern with the components needed when you want to create templates for a model
    module Templatable
      extend ActiveSupport::Concern

      included do
        has_one :template,
                class_name: "Decidim::Templates::Template",
                inverse_of: :templatable,
                as: :templatable

        def pristine?
          created_at == updated_at
        end
      end
    end
  end
end
