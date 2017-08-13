module CaptainsHelper
  def display_captain(boat)
    if boat.captain_name.present?
      link_to boat.captain_name, captain_path(boat.captain)
    else
      link_to "Appoint Captain", edit_boat_path(boat)
    end
  end
end
