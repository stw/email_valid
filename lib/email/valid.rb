module Email
  class Valid
    attr_accessor :check_domain, :check_rfc822, :errors
    
    class << self
      # class method to check for email address validity
      def address(email, args = {})
        obj = self.new(args)
        obj.valid(email)
      end
    end
    
    def initialize(args)
      @errors = []
      # check mx, default on
      @check_domain = (args[:check_domain].nil? ? true : args[:check_domain])
      
      # check pattern, default on
      @check_rfc822 = (args[:check_rfc822].nil? ? true : args[:check_rfc822])
    end
    
    # checks email address for validity
    def valid(email)
      valid_rfc822(email) && valid_domain(email)
    end
    
    # checks against the rfc822 pattern
    def valid_rfc822(email)
      return true unless check_rfc822 == true
      if email =~ rfc822
        true
      else
        errors << "Does not conform to rfc822"
        false
      end
    end
    
    # check for valid mx record
    def valid_domain(email)
      return true unless check_domain == true
      domain = email.match(/\@(.+)/)[1]
      Resolv::DNS.open do |dns|
          @mx = dns.getresources(domain, Resolv::DNS::Resource::IN::MX)
      end
      if @mx.size > 0 
        true
      else
        errors << "Invalid Domain (no mx record)"
        false
      end
    end
  end
end