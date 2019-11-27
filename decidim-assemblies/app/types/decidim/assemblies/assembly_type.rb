# frozen_string_literal: true

module Decidim
  module Assemblies
    # This type represents a assembly.
    AssemblyType = GraphQL::ObjectType.define do
      interfaces [
        -> { Decidim::Core::ParticipatorySpaceInterface },
      ]

      name "Assembly"
      description "An assembly"

      field :subtitle, Decidim::Core::TranslatedFieldType, "The subtitle of this assembly"
      field :short_description, Decidim::Core::TranslatedFieldType, "The sort description of this assembly"
      field :description, Decidim::Core::TranslatedFieldType, "The description of this assembly"
      field :slug, !types.String
      field :hashtag, types.String, "The hashtag for this assembly"
      field :createdAt, !Decidim::Core::DateTimeType, "The time this assembly was created", property: :created_at
      field :updatedAt, !Decidim::Core::DateTimeType, "The time this assembly was updated", property: :updated_at
      field :publishedAt, !Decidim::Core::DateTimeType, "The time this assembly was updated", property: :published_at
      field :reference, !types.String, "Reference prefix for this assembly"

      field :heroImage, types.String, "The hero image for this assembly", property: :hero_image
      field :bannerImage, types.String, "The banner image for this assembly", property: :banner_image
      field :promoted, types.Boolean, "If this assembly is promoted (therefore in the homepage)"
      field :developerGroup, Decidim::Core::TranslatedFieldType, "The promoter group of this assembly", property: :developer_group
      field :metaScope, Decidim::Core::TranslatedFieldType, "The scope metadata of this assembly", property: :meta_scope
      field :localArea, Decidim::Core::TranslatedFieldType, "The organization area of this assembly", property: :local_area
      field :target, Decidim::Core::TranslatedFieldType, "Who participates in this assembly"
      field :participatoryScope, Decidim::Core::TranslatedFieldType, "What is decided on this assembly", property: :participatory_scope
      field :participatoryStructure, Decidim::Core::TranslatedFieldType, "How it is decided on this assembly", property: :participatory_structure
      field :showStatistics, types.Boolean, "If this assembly should show statistics", property: :show_statistics
      field :scopesEnabled, types.Boolean, "If this assembly has scopes enabled", property: :scopes_enabled
      field :privateSpace, types.Boolean, "If this assembly is a private space", property: :private_space
      field :decidimAreaId, types.Int, "", property: :decidim_area_id
      field :parentId, types.Int, "", property: :parent_id
      field :parentsPath, types.String, "", property: :parents_path
      field :childrenCount, types.Int, "", property: :children_count
      field :purposeOfAction, Decidim::Core::TranslatedFieldType, "Purpose of action", property: :purpose_of_action
      field :composition, Decidim::Core::TranslatedFieldType, "Composition of this assembly"
      field :assemblyType, types.String, "Type of the assembly", property: :assembly_type
      field :creationDate, Decidim::Core::DateType, "Creation date of this assembly", property: :creation_date
      field :createdByOther, Decidim::Core::TranslatedFieldType, "Created by other", property: :created_by_other
      field :duration, Decidim::Core::DateType, "Duration of this assembly"
      field :includedAt, Decidim::Core::DateType, "Included at", property: :included_at
      field :closingDate, Decidim::Core::DateType, "Closing date of the assembly", property: :closing_date
      field :closingDateReason, Decidim::Core::TranslatedFieldType, "Closing date reason of this assembly", property: :closing_date_reason
      field :internalOrganisation, Decidim::Core::TranslatedFieldType, "Internal organisation of this assembly", property: :internal_organisation
      field :isTransparent, types.Boolean, "If this assembly is transparent", property: :is_transparent
      field :specialFeatures,  Decidim::Core::TranslatedFieldType, "Special features of this assembly", property: :special_features
      field :twitterHandler, types.String, "Twitter handler", property: :twitter_handler
      field :instagramHandler, types.String, "Instagram handler", property: :instagram_handler
      field :facebookHandler, types.String, "Facebook handler", property: :facebook_handler
      field :youtubeHandler, types.String, "Youtube handler", property: :youtube_handler
      field :githubHandler, types.String, "Github handler", property: :github_handler

      # These fields may be private:
      # decidim_participatory_process_group_id
      # decidim_organization_id
      # private_space
    end
  end
end