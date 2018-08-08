module RequestHandler

  def date_format(value)
    value&.in_time_zone('UTC')&.strftime('%Y-%m-%d')
  end
end
