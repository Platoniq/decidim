#spec/show_spec.rb

require "spec_helper"

describe Show do
	describe "Decidim/decidim/decidim-debates/app/views/decidim/debates/debates/show.html.erb" do
		it "shows extra date" do
			show = Show.new

			expect(debate.start_time.present)
			render :partial => "Decidim/decidim/decidim-debates/app/views/decidim/debates/debates/show.html.erb", :locals => {:widget => widget}
			
			context "show dates" do
				def debate.start_time.present?
					it "shows the date" do
						within ".card__content--multiple" do
							expect(page).to have_content(debate.start_time.strftime("%d"))
							expect(page).to have_content(debate.start_time.strftime("%H:%M"))
						end
					end
				end
			
				before do
			
				def debate.end_time.present?
					it "shows the extra date" do
						within ".card__content--multiple" do
							expect(page).to have_content(debate.end_time.strftime("%d"))
							expect(page).to have_content(debate.end_time.strftime("%H:%M"))
						end
					end
				end
			end
		end
	end
end
