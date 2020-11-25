# frozen_string_literal: true

module Decidim
  module Comments
    class Permissions < Decidim::DefaultPermissions
      def permissions
        return permission_action if permission_action.subject != :comment

        case permission_action.action
        when :read
          can_read_comments?
        when :create
          return unless authorized? :create
          can_create_comment?
        when :vote
          return unless authorized? :vote
          can_vote_comment?
        end

        permission_action
      end

      private

      def authorized?(permission_action, resource: nil)
        return unless comment || commentable

        ActionAuthorizer.new(user, permission_action, comment, commentable).authorize.ok?
      end

      def can_read_comments?
        return disallow! unless commentable.commentable?

        allow!
      end

      def can_create_comment?
        return disallow! unless user
        return disallow! unless commentable.commentable?
        return disallow! unless commentable&.user_allowed_to_comment?(user)

        allow!
      end

      def can_vote_comment?
        return disallow! unless user
        return disallow! unless commentable&.user_allowed_to_comment?(user)

        allow!
      end

      def commentable
        @commentable ||= begin
          if comment
            comment.root_commentable
          else
            context.fetch(:commentable, nil)
          end
        end
      end

      def comment
        @comment ||= context.fetch(:comment, nil)
      end
    end
  end
end
