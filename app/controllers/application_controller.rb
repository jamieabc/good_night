class ApplicationController < ActionController::API
  def success_json
    { message: 'OK' }
  end

  def failed_json
    { failed: 'FAILED' }
  end
end
