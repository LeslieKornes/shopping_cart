module CustomSessionBehavior
  def session_count_ticker
    session[:counter] += 1 
    puts "####### incrementing counter #{session.to_h} #######"
  end

  def puts_signout
    puts "####### destroying: #{session.to_h} #######"
  end

  def confirm_fresh_sesh
    puts "####### signed out #{session.to_h} #######"
  end
end
