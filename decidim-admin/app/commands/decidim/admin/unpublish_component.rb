# frozen_string_literal: true

module Decidim
  module Admin
    # This command gets called when a component is unpublished from the admin panel.
    class UnpublishComponent < Rectify::Command
      # Public: Initializes the command.
      #
      # component - The component to unpublish.
      # current_user - the user performing the action
      def initialize(component, current_user)
        @component = component
        @current_user = current_user
      end

      # Public: Unpublishes the Component.
      #
      # Broadcasts :ok if unpublished, :invalid otherwise.
      def call
        unpublish_component
        unpublish_event

        broadcast(:ok)
      end

      private

      attr_reader :component, :current_user

      def unpublish_component
        Decidim.traceability.perform_action!(
          :unpublish,
          component,
          current_user
        ) do
          component.unpublish!
          component
        end
      end

      def unpublish_event
        Decidim::EventsManager.publish(
          event: "decidim.events.components.component_unpublished",
          event_class: Decidim::ComponentUnpublishedEvent,
          resource: component,
          followers: component.participatory_space.followers
        )
      end
    end
  end
end
