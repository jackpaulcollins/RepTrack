require "application_system_test_case"

class ReportsTest < ApplicationSystemTestCase
  setup do
    @report = reports(:one)
  end

  test "visiting the index" do
    visit reports_url
    assert_selector "h1", text: "Reports"
  end

  test "creating a Report" do
    visit reports_url
    click_on "New Report"

    fill_in "Account", with: @report.account_id
    fill_in "Points", with: @report.points
    fill_in "Rep count", with: @report.rep_count
    fill_in "Rep type", with: @report.rep_type
    fill_in "User", with: @report.user_id
    click_on "Create Report"

    assert_text "Report was successfully created"
    assert_selector "h1", text: "Reports"
  end

  test "updating a Report" do
    visit report_url(@report)
    click_on "Edit", match: :first

    fill_in "Account", with: @report.account_id
    fill_in "Points", with: @report.points
    fill_in "Rep count", with: @report.rep_count
    fill_in "Rep type", with: @report.rep_type
    fill_in "User", with: @report.user_id
    click_on "Update Report"

    assert_text "Report was successfully updated"
    assert_selector "h1", text: "Reports"
  end

  test "destroying a Report" do
    visit edit_report_url(@report)
    click_on "Delete", match: :first
    click_on "Confirm"

    assert_text "Report was successfully destroyed"
  end
end
