# frozen_string_literal: true

module Decidim
  class ProfileCell < Decidim::ViewModel
    include Decidim::ApplicationHelper
    include Decidim::Core::Engine.routes.url_helpers
    include Decidim::UserProfileHelper
    include Decidim::AriaSelectedLinkToHelper
    include ActiveLinkTo

    delegate :current_organization, :current_user, :user_groups_enabled?, to: :controller

    def show
      render :show
    end

    def profile_holder
      model
    end

    def content_cell
      context[:content_cell]
    end

    def active_content
      context[:active_content]
    end

    def own_profile?
      current_user && current_user == profile_holder
    end

    def manageable_group?
      return false unless profile_holder.is_a?(Decidim::UserGroup)

      current_user && current_user.manageable_user_groups.include?(profile_holder)
    end

    def profile_tabs
      return render :user_group_tabs if profile_holder.is_a?(Decidim::UserGroup)

      render :user_tabs
    end

    def unread_count
      @unread_count ||= Decidim::Messaging::Receipt.unread_count(current_user)
    end

    def label_conversations
      label = I18n.t("decidim.profiles.show.conversations")
      label = "#{label} <span class=\"badge\">#{unread_count}</span>" if unread_count
      label
    end
  end
end
