# encoding: utf-8

module ResponseHandler
  def success?(response_code, response_body)
    (response_code == 200) && (!string_error_response?(response_body) && !hash_error_response?(response_body))
  end

  def string_error_response?(response_body)
    response_body.instance_of?(String) && response_body =~ /error/
  end

  def hash_error_response?(response_body)
    response_body.instance_of?(Hash) && response_body.key?(:error)
  end

  def response_values(response)
    response_code = nil
    response_body = nil
    if response
      response_code = response.code
      response_body = response.body
    end
    [response_code, response_body]
  end
end
