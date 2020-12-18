# frozen_string_literal: true

require "spec_helper"

describe "show multiple dates", versioning:true, type: :system do
  include_context "with a component"
  let(:manifest_name) { "debates" }
  let!(:debate) { create(:debate, component: component, start_time: start_time, end_time: end_time) }
  let!(:start_time) { Time.current - 1.hour }
  let(:end_time) { Time.current }

  context "when start date and end date are different" do
    let(:start_time) { Time.current - 1.day}

    it "compare the dates" do
      within ".extra__date" do
        expect(debate.start_time.strftime("%d%m")).not_to eq(debate.end_time.strftime("%d%m"))
    end

    it "shows the start and end date" do
      within ".extra__date" do
        expect(page).to have_content(debate.start_time.strftime("%d"))
        expect(page).to have_content(debate.start_time.strftime("%H:%M"))
        expect(page).to have_content(debate.end_time.strftime("%d"))
        expect(page).to have_content(debate.end_time.strftime("%H:%M"))
      end
    end
  end

  context "when start date and end date are the same" do
    it "compare the days" do
      within ".extra__date" do
        expect(debate.start_time.strftime("%m%Y")).to eq(debate.end_time.strftime("%m%Y"))
        expect(debate.start_time.strftime("%H").to be < debate.end_time.strftime("%H"))
      end
    end
    it "show the day" do
      within ".extra__date" do
        expect(page).to have_content(debate.start_time.strftime("%d"))
        expect(page).to have_content(debate.start_time.strftime("%H:%M"))
        expect(page).to have_content(debate.end_time.strftime("%H:%M"))
      end
    end
  end

  context "when start and end day has the same but the month are different"
  let(:start_time) { Time.current - 1.month }
    it "compare the dates" do
      within ".extra__date" do
        expect(debate.start_time.strftime("%d")).to eq(debate.end_time.strftime("%d"))
        expect(debate.start_time.strftime("%m")).not_to eq(debate.end_time.strftime("%m"))
      end
    end
    it "shows two days" do
      within ".card_content" do
        expect(page).to have_content(debate.start_time.strftime("%d"))
        expect(page).to have_content(debate.start_time.strftime("%H:%M"))
        expect(page).to have_content(debate.end_time.strftime("%d"))
        expect(page).to have_content(debate.end_time.strftime("%H:%M"))
      end
    end
  end

  context "when there is no end date" do
    it "show only start date" do
      within ".card_content" do
        expect(page).not_to have_content(debate.end_time.strftime("%d"))
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
