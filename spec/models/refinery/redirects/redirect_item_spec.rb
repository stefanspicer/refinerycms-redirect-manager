require 'spec_helper'

module Refinery
  module Redirects
    describe RedirectItem do
      describe "validations", type: :model do
        subject do
          FactoryGirl.create(:redirect_item,
          :src_path => "Refinery CMS")
        end

        it { should be_valid }
        its(:errors) { should be_empty }
        its(:src_path) { should == "Refinery CMS" }
      end
    end
  end
end
