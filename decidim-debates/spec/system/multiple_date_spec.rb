# frozen_string_literal: true

require "spec_helper"

describe "show multiple dates", type: :system do
  include_context "with a component"
  let(:manifest_name) { "debates" }

  let!(:debate) { create(:debate, component: component) }

  before do
    visit_component
    click_link debate.title[I18n.locale.to_s], class: "card__content--multiple"
  end

  context "when shows the debate component" do
    it "shows the start date" do
      within ".card__content--multiple" do
        expect(page).to have_content(debate.start_time.strftime("%d"))
        expect(page).to have_content(debate.start_time.strftime("%H:%M"))
      end
    end

    it "shows the end date" do
      within ".card__content--multiple" do
        expect(page).to have_content(debate.end_time.strftime("%d"))
        expect(page).to have_content(debate.end_time.strftime("%H:%M"))
      end
    end
  end
end
