require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "full_title" do
    it "引数が渡されている場合、動的な表示がされていること" do
      expect(full_title("Pagetitle")).to eq "Pagetitle / Price Increase"
    end

    it "引数が空白の場合、タイトルが表示されること" do
      expect(full_title("")).to eq "Price Increase"
    end

    it "引数がnilの場合、タイトルが表示されること" do
      expect(full_title(nil)).to eq "Price Increase"
    end
  end
end
