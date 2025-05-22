class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :track_last_visit
  before_action :track_page_visits

  helper_method :last_visited_ago, :total_visits, :page_visits, :time_greeting

  private

  def track_last_visit
    @last_visited_at = session[:last_visited_at] ? Time.zone.parse(session[:last_visited_at]) : nil
    session[:last_visited_at] = Time.zone.now.to_s
  end

  def last_visited_ago
    return "Never" unless @last_visited_at
    diff = Time.zone.now - @last_visited_at
    if diff < 60
      "Last visited: #{diff.to_i} seconds ago"
    elsif diff < 3600
      "Last visited: #{(diff / 60).to_i} minutes ago"
    elsif diff < 86400
      "Last visited: #{(diff / 3600).to_i} hours ago"
    else
      "Last visited: #{(diff / 86400).to_i} days ago"
    end
  end

  def track_page_visits
    session[:total_visits] ||= 0
    session[:total_visits] += 1

    session[:page_visits] ||= {}
    page = "#{controller_name}##{action_name}"
    session[:page_visits][page] ||= 0
    session[:page_visits][page] += 1
  end

  def total_visits
    session[:total_visits] || 0
  end

  def page_visits
    session[:page_visits] || {}
  end

  def time_greeting
    hour = Time.zone.now.hour
    case hour
    when 5..11
      "Good morning!"
    when 12..16
      "Good afternoon!"
    when 17..20
      "Good evening!"
    else
      "Good night!"
    end
  end
end
