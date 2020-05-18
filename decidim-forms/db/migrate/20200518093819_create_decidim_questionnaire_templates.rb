# frozen_string_literal: true

class CreateDecidimQuestionnaireTemplates < ActiveRecord::Migration[5.2]
  def change
    create_table :decidim_questionnaire_templates do |t|
      t.integer :decidim_organization_id, null: false, index: { name: "index_decidim_questionnaire_templates_organization" }
      t.references :questionnaire, index: { name: "index_decidim_questionnaire_templates_questionnaire" }
      t.jsonb :title
      t.jsonb :description

      t.timestamps
    end
  end
end
