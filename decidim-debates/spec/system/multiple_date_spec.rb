# frozen_string_literal: true

require "spec_helper"

describe "show multiple dates", versioning: true, type: :system do
  include_context "with a component"
  let(:manifest_name) { "debates" }
  let!(:debate) { create(:debate, component: component, start_time: start_time, end_time: end_time) }
  let!(:start_time) { Time.current - 1.hour }
  let(:end_time) { Time.current }

  before do
    visit_component
    click_link debate.title[I18n.locale.to_s], class: "card__link"
  end

  context "when debate start and end on different day" do
    let(:start_time) { Time.current - 1.day }

    it "shows two days" do
      within ".extra__date" do
        expect(page).to have_content(debate.start_time.strftime("%d"))
        expect(page).to have_content(debate.start_time.strftime("%H:%M"))
        expect(page).to have_content(debate.end_time.strftime("%d"))
        expect(page).to have_content(debate.end_time.strftime("%H:%M"))
      end
    end

    it "check that the two days are different" do
      within ".extra__date" do
        expect(debate.start_time.strftime("%d%m")).not_to eq(debate.end_time.strftime("%d%m"))
      end
    end
  end

  context "when start and end date are the same" do
    it "comprove the hours" do
      within ".extra__date" do
        expect(debate.start_time.strftime("%H")).to be <debate.end_time.strftime("%H")
        expect(debate.start_time.strftime("%m%Y")).to eq(debate.end_time.strftime("%m%Y"))
      end
    end

    it "shows the hours" do
      within ".extra__date" do
        expect(page).to have_content(debate.start_time.strftime("%d"))
        expect(page).to have_content(debate.start_time.strftime("%H:%M"))
        expect(page).to have_content(debate.end_time.strftime("%H:%M"))
      end
    end
  end

  context "when start and end on same day but different month" do
    let(:start_time) { Time.current - 1.month }

    it "shows two days" do
      within ".extra__date" do
        expect(debate.start_time.strftime("%d")).to eq(debate.end_time.strftime("%d"))
        expect(debate.start_time.strftime("%m")).not_to eq(debate.end_time.strftime("%m"))
      end
    end

    it "shows two dates" do
      within ".extra__date" do
        expect(page).to have_content(debate.start_time.strftime("%d"))
        expect(page).to have_content(debate.start_time.strftime("%H:%M"))
        expect(page).to have_content(debate.end_time.strftime("%d"))
        expect(page).to have_content(debate.end_time.strftime("%H:%M"))
      end
    end
  end
end
