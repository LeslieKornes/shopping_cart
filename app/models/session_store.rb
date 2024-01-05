
class SessionStore
  include ActionController::Helpers

  def initialize(request = nil)
    @request = request
    @session_id = request&.session_options[:id] || generate_session_id
  end

  def [](key)
    @request.session[key]
  end

  def []=(key, value)
    return unless @request
    @request.session[key] = value
  end

  def delete(key)
    @request.session.delete(key)
  end

  def clear
    @request.session.clear
  end

  def puts_something
    puts "hello"
  end
end