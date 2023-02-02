# frozen_string_literal: true

require "spec_helper"

module Decidim
  module Admin
    describe ImportForm do
      subject { form }

      let(:organization) { create(:organization) }
      let!(:component) { create(:dummy_component, organization: organization) }
      let(:user) { create(:user, :confirmed, :admin, organization: organization) }
      let(:file) { Decidim::Dev.test_file("import_proposals.csv", "text/csv") }
      let(:name) { "dummies" }

      let(:params) { { file: file, name: name } }

      let(:form) do
        described_class.from_params(params).with_context(
          current_organization: organization,
          current_component: component,
          current_user: user
        )
      end

      context "when everything is OK" do
        it { is_expected.to be_valid }
      end

      context "when content type is not accepted" do
        let(:file) { Decidim::Dev.test_file("city.jpeg", "image/jpeg") }

        it { is_expected.not_to be_valid }
      end

      context "when the file is not a valid file" do
        let(:file) { Decidim::Dev.test_file("Exampledocument.pdf", Decidim::Admin::Import::Readers::XLSX::MIME_TYPE) }

        it "reports invalid and adds the correct error for the file field" do
          expect(subject).not_to be_valid
          expect(subject.errors[:file]).to include("Invalid file provided, please check that the file is correctly formatted")
        end
      end
    end
  end
end
