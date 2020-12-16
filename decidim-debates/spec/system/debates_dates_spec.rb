# frozen_string_literal: true

require "spec_helper"

describe "Debate dates", versioning: true, type: :system do
  include_context "with a component"
  let(:manifest_name) { "debates" }

  let!(:debate) { create(:debate, component: component, start_time: start_time, end_time: end_time) }
  let(:start_time) { Time.current - 1.hour }
  let(:end_time) { Time.current }

  before do
    visit_component
    click_link debate.title[I18n.locale.to_s], class: "card__link"
  end

  context "when starting and ending on same day" do
    it "shows one day only" do
      within ".extra__date" do
        expect(page).to have_content(debate.start_time.strftime("%d"))
        expect(page).to have_content(debate.start_time.strftime("%H:%M"))
        expect(page).to have_content(debate.end_time.strftime("%H:%M"))
      end
    end

    it "shows two hours" do
      within ".extra__date" do
        expect(debate.start_time("%H")).to be <debate.end_time.strftime("%H")
        expect(debate.end_time("%H")).to be > debate.start_time.strftime("%H")
        expect(debate.start_time("%M%Y")).to eq(debate.end_time.strftime("%M%Y"))
      end
    end
  end

  context "when starting and ending same day but different month" do
    it "shows two days" do
      within ".extra__date" do
        debate.start_time = Time.current - 1.month
        expect(page).to have_content(debate.start_time.strftime("%d"))
        expect(page).to have_content(debate.start_time.strftime("%H:%M"))
        expect(page).to have_content(debate.end_time.strftime("%d"))
        expect(page).to have_content(debate.end_time.strftime("%H:%M"))
      end
    end

    it "shows two dates" do
      within ".extra__date" do
        debate.start_time = Time.current - 1.month
        expect(debate.start_time("%d")).to eq(debate.end_time.strftime("%d"))
        expect(debate.start_time("%M")).not_to eq(debate.end_time.strftime("%M"))
      end
    end
  end

  context "when starting and ending on different day" do
    it "shows two days" do
      debate.start_time = Time.current - 1.day.ago
      expect(page).to have_content(debate.start_time.strftime("%d"))
      expect(page).to have_content(debate.start_time.strftime("%H:%M"))
      expect(page).to have_content(debate.end_time.strftime("%d"))
      expect(page).to have_content(debate.end_time.strftime("%H:%M"))
    end

    it "shows two dates" do
      debate.start_time = Time.current - 1.day.ago
      expect(debate.start_time("%d%M")).not_to eq(debate.end_time.strftime("%d%M"))
    end
  end
end
