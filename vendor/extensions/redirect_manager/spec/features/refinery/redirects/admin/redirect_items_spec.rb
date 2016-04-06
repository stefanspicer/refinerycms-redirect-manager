# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "Redirects" do
    describe "Admin" do
      describe "redirect_items", type: :feature do
        refinery_login

        describe "redirect_items list" do
          before do
            FactoryGirl.create(:redirect_item, :src_path => "UniqueTitleOne")
            FactoryGirl.create(:redirect_item, :src_path => "UniqueTitleTwo")
          end

          it "shows two items" do
            visit refinery.redirects_admin_redirect_items_path
            expect(page).to have_content("UniqueTitleOne")
            expect(page).to have_content("UniqueTitleTwo")
          end
        end

        describe "create" do
          before do
            visit refinery.redirects_admin_redirect_items_path

            click_link "Add New Redirect Item"
          end

          context "valid data" do
            it "should succeed" do
              fill_in "Src Path", :with => "This is a test of the first string field"
              expect { click_button "Save" }.to change(Refinery::Redirects::RedirectItem, :count).from(0).to(1)

              expect(page).to have_content("'This is a test of the first string field' was successfully added.")
            end
          end

          context "invalid data" do
            it "should fail" do
              expect { click_button "Save" }.not_to change(Refinery::Redirects::RedirectItem, :count)

              expect(page).to have_content("Src Path can't be blank")
            end
          end

          context "duplicate" do
            before { FactoryGirl.create(:redirect_item, :src_path => "UniqueTitle") }

            it "should fail" do
              visit refinery.redirects_admin_redirect_items_path

              click_link "Add New Redirect Item"

              fill_in "Src Path", :with => "UniqueTitle"
              expect { click_button "Save" }.not_to change(Refinery::Redirects::RedirectItem, :count)

              expect(page).to have_content("There were problems")
            end
          end

        end

        describe "edit" do
          before { FactoryGirl.create(:redirect_item, :src_path => "A src_path") }

          it "should succeed" do
            visit refinery.redirects_admin_redirect_items_path

            within ".actions" do
              click_link "Edit this redirect item"
            end

            fill_in "Src Path", :with => "A different src_path"
            click_button "Save"

            expect(page).to have_content("'A different src_path' was successfully updated.")
            expect(page).not_to have_content("A src_path")
          end
        end

        describe "destroy" do
          before { FactoryGirl.create(:redirect_item, :src_path => "UniqueTitleOne") }

          it "should succeed" do
            visit refinery.redirects_admin_redirect_items_path

            click_link "Remove this redirect item forever"

            expect(page).to have_content("'UniqueTitleOne' was successfully removed.")
            expect(Refinery::Redirects::RedirectItem.count).to eq(0)
          end
        end

      end
    end
  end
end
