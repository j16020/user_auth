require "application_system_test_case"

class AdminEventsTest < ApplicationSystemTestCase
  setup do
    @admin_event = admin_events(:one)
  end

  test "visiting the index" do
    visit admin_events_url
    assert_selector "h1", text: "Admin Events"
  end

  test "creating a Admin event" do
    visit admin_events_url
    click_on "New Admin Event"

    fill_in "Title", with: @admin_event.title
    click_on "Create Admin event"

    assert_text "Admin event was successfully created"
    click_on "Back"
  end

  test "updating a Admin event" do
    visit admin_events_url
    click_on "Edit", match: :first

    fill_in "Title", with: @admin_event.title
    click_on "Update Admin event"

    assert_text "Admin event was successfully updated"
    click_on "Back"
  end

  test "destroying a Admin event" do
    visit admin_events_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Admin event was successfully destroyed"
  end
end
