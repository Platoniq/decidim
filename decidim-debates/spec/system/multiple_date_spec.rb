# frozen_string_literal: true

require "spec_helper"

describe "show multiple dates", type: :system do
  include_context "with a component"
  let(:manifest_name) { "debates" }
  let!(:debate) { create(:debate, component: component) }
  let!(:start_time) { Time.current - 1.hour }
  let(:end_time) { Time.current }

  context "when start date and end date are diffrent" do
    it "shows the start date" do
      within ".extra__date" do
        expect(page).to have_content(debate.start_time.strftime("%d"))
        expect(page).to have_content(debate.start_time.strftime("%H:%M"))
      end
    end

    it "shows the end date" do
      within ".extra__date" do
        expect(page).to have_content(debate.end_time.strftime("%d"))
        expect(page).to have_content(debate.end_time.strftime("%H:%M"))
      end
    end
  end

  context "when start date and end date are the same" do
    it "shows the dates" do
      within ".extra__date" do
        expect(debate.start_time).to eq(debate.end_time)
        expect(page).to have_content(debate.start_time.strftime("%H:%M"))
      end
    end
  end

  context "when start date and end date are the same" do
    it "shows the dates" do
      within ".extra__date" do
        expect(debate.start_time).to eq(debate.end_time)
        expect(page).to have_content(debate.start_time.strftime("%H:%M"))
      end
    end
  end

  context "when there is no end date" do
    it "show only start date" do
      within ".extra__date" do
        expect(page).to have_content(debate.end_time.strftime("%H:%M"))
        expect(page).to have_content(debate.start_time.strftime("%H:%M"))
      end
    end

    it "doesn't have end date" do
      within ".extra__date" do
        expect(page).not_to have_content(debate.end_time.strftime("%d"))
        expect(page).not_to have_content(debate.end_time.strftime("%H:%M"))
      end
    end
  end
end
