# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  GetText.locale = 'de_DE'
  init_gettext "cbp" 
  include AuthenticatedSystem
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'fb603fd49cbf881f0c5572e1fc30db86'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  before_filter :define_language

  def define_language
    # here you can switch the locale on fly
    # say like that

    case params[:lang]
      when 'en': set_locale 'en_EN'
      when 'fr': set_locale 'fr_FR'
      when 'ru': set_locale 'ru_RU'
      else       set_locale 'de_DE'
    end
  end
  
  private
  

  
end
