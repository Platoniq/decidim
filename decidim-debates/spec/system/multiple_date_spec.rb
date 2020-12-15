# frozen_string_literal: true

require "spec_helper"

describe "show multiple dates", type: :system do
  include_context "with a component"
  let(:manifest_name) { "debates" }

  let!(:debate) { create(:debate, component: component) }

  context "when shows the debate component" do
    it "shows the start date" do
      within "extra__date" do
        expect(page).to have_content(debate.start_time.strftime("%d"))
        expect(page).to have_content(debate.start_time.strftime("%H:%M"))
      end
    end

    it "shows the end date" do
      within "extra__date" do
        expect(page).to have_content(debate.end_time.strftime("%d"))
        expect(page).to have_content(debate.end_time.strftime("%H:%M"))
      end
    end
  end
end
