# frozen_string_literal: true

module Decidim
  module Comments
    # A helper to expose the comments component for a commentable
    module CommentsHelper
      # Render commentable comments inside the `expanded` template content.
      #
      # resource - A commentable resource
      def comments_for(resource)
        return unless resource.commentable?

        content_for :expanded do
          inline_comments_for(resource)
        end
      end

      # Creates a Comments component which is rendered using `ReactDOM`
      #
      # resource - A commentable resource
      #
      # Returns a div which contain a RectComponent
      def inline_comments_for(resource)
        return unless resource.commentable?

        commentable_type = resource.commentable_type
        commentable_id = resource.id.to_s
        commentable_path = resource_locator(resource).path
        # actions a quite linke to objects belonging to a component
        # In consultations, a question belong to a participatory_space but it has comments
        # To apply :comment permission, the modal authorizer should be refactored to allow participatory spaces children
        if resource.respond_to?(:component)
          commentable_path = action_authorized_link_to(:comment, t("decidim.components.comments.blocked_comments_for_unauthorized_user_warning"), commentable_path, resource: resource)
        end
        node_id = "comments-for-#{commentable_type.demodulize}-#{commentable_id}"
        react_comments_component(node_id, commentableType: commentable_type,
                                          commentableId: commentable_id,
                                          locale: I18n.locale,
                                          authorizationLink: commentable_path)
      end

      # Private: Render Comments component using inline javascript
      #
      # node_id - The id of the DOMElement to render the React component
      # props   - A hash corresponding to Comments component props
      def react_comments_component(node_id, props)
        content_tag("div", "", id: node_id) +
          javascript_include_tag("decidim/comments/comments") +
          javascript_tag(%{
            window.DecidimComments.renderCommentsComponent(
              '#{node_id}',
              {
                commentableType: "#{props[:commentableType]}",
                commentableId: "#{props[:commentableId]}",
                locale: "#{props[:locale]}",
                authorizationLink: "#{j props[:authorizationLink]}"
              }
            );
          })
      end
    end
  end
end
