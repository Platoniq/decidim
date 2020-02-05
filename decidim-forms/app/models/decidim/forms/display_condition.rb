# frozen_string_literal: true

module Decidim
  module Forms
    # The data store for a DisplayCondition in the Decidim::Forms component.
    class DisplayCondition < Forms::ApplicationRecord
      enum condition_type: [:answered, :not_answered, :equal, :not_equal, :match], _prefix: true

      belongs_to :question, class_name: "Question", foreign_key: "decidim_question_id", inverse_of: :display_conditions
      belongs_to :condition_question, class_name: "Question", foreign_key: "decidim_condition_question_id", inverse_of: :display_conditions_for_other_questions
      belongs_to :answer_option, class_name: "AnswerOption", foreign_key: "decidim_answer_option_id", optional: true

      def fulfilled?(answer)
        case condition_type
        when "answered"
          answer.present?
        when "not_answered"
          answer.blank?
        when "equal"
          answer.choices.pluck(:decidim_answer_option_id).include?(answer_option.id)
        when "not_equal"
          !answer.choices.pluck(:decidim_answer_option_id).include?(answer_option.id)
        when "match"
          condition_value.values.any? { |value| answer.body.match?(Regexp.new(value, Regexp::IGNORECASE)) }
        end
      end
    end
  end
end
