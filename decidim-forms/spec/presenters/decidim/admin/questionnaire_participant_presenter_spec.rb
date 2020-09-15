# frozen_string_literal: true

require "spec_helper"

module Decidim
  describe Forms::Admin::QuestionnaireParticipantPresenter, type: :helper do
    subject { described_class.new(participant: participant) }

    let!(:questionnaire) { create(:questionnaire) }
    let!(:user) { create(:user, organization: questionnaire.questionnaire_for.organization) }
    let!(:questions) { 3.downto(1).map { |n| create :questionnaire_question, questionnaire: questionnaire, position: n } }
    let!(:answers) do
      questions.reject { |q| q.question_type == Forms::Question::SEPARATOR_TYPE }.map { |question| create :answer, user: user, questionnaire: questionnaire, question: question }.sort_by { |a| a.question.position }
    end
    let!(:answer) { subject.answers.first.answer }
    let!(:participant) { answers.first }

    describe "ip_hash" do
      context "when participant's ip_hash is present" do
        before do
          answer.update(ip_hash: "some ip")
        end

        it "returns participant ip hash" do
          answers.first.reload
          expect(subject.ip_hash).to eq(answer.ip_hash)
        end
      end

      context "when participant's ip_hash is missing" do
        before do
          answer.update(ip_hash: nil)
        end

        it "returns a hyphen '-'" do
          answers.first.reload
          expect(subject.ip_hash).to eq("-")
        end
      end
    end

    describe "answered_at" do
      it "returns the datetime when the answer was created" do
        answers.first.reload
        expect(subject.answered_at).to eq(answer.created_at)
      end
    end

    describe "registered?" do
      it "returns whether the participant is registered (has an id)" do
        expect(subject.registered?).to eq(answer.decidim_user_id.present?)
      end
    end

    describe "answers" do
      it "returns the participant's answers" do
        expect(subject.answers.map(&:answer)).to eq(answers)
      end
    end

    describe "completion" do
      context "when all questions are answered" do
        it "returns the participant's completion percentage" do
          expect(subject.completion).to eq(100)
        end
      end
      
      context "when not all questions are answered" do
        let!(:answers) { questions.first(2).map { |question| create :answer, user: user, questionnaire: questionnaire, question: question }.sort_by { |a| a.question.position }}

        it "returns the participant's completion percentage" do
          expect(subject.completion).to eq(2.0 / 3 * 100)
        end
      end
      
      context "when there are separator type questions" do
        let!(:questions) do
          [
            create(:questionnaire_question, questionnaire: questionnaire, position: 1),
            create(:questionnaire_question, questionnaire: questionnaire, position: 2),
            create(:questionnaire_question, questionnaire: questionnaire, position: 3, question_type: Forms::Question::SEPARATOR_TYPE),
            create(:questionnaire_question, questionnaire: questionnaire, position: 4)
          ]
        end

        it "ignores separator questions in count" do
          expect(subject.completion).to eq(100)
        end
      end
    end
  end
end
