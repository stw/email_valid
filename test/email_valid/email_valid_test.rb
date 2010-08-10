# 
#  test_email_valid.rb
#  
#  Created by Stephen Walker on 2010-08-10.
#  Copyright 2010 Stephen Walker. All rights reserved.
# 

require 'test/unit'
require 'rubygems'


$:.unshift File.dirname(__FILE__) + '/../../lib'
require 'email'

class Test::Unit::TestCase
end

class EmailValidTest < Test::Unit::TestCase
  
  def setup
    @email_with_domain  = Email::Valid.new(:check_domain => true, :check_rfc822 => true)
    @email_witho_domain = Email::Valid.new(:check_domain => false, :check_rfc822 => true)
  end
  
  def teardown
  end
  
  def test_email_class_method
    assert_equal true, Email::Valid.address('swalker@walkertek.com'), "Testing: swalker@walkertek.com"
    assert_equal true, Email::Valid.address('swalker@blackboxweb.com'), "Testing: swalker@blackboxweb.com"
    assert_equal false, Email::Valid.address('swalker@blackbox.us'), "Testing: swalker@blackbox.us"
    assert_equal false, Email::Valid.address('swalker@com'), "Testing: swalker@com"
  end
  
  def test_email_valid
    assert_equal true, @email_with_domain.valid('swalker@walkertek.com'), "Testing: swalker@walkertek.com"
    assert_equal true, @email_with_domain.valid('swalker@blackboxweb.com'), "Testing: swalker@blackboxweb.com"
    assert_equal false, @email_with_domain.valid('swalker@blackbox.us'), "Testing: swalker@blackbox.us"
    assert_equal false, @email_with_domain.valid('swalker@com'), "Testing: swalker@com"
  end
  
  def test_email_valid_failures
    assert_equal false, @email_with_domain.valid('swalker.walkertek.com'), "Testing: swalker.walkertek.com"
    assert_equal false, @email_with_domain.valid('walkertek.com'), "Testing: walkertek.com"
    assert_equal false, @email_with_domain.valid('swalker@.com'), "Testing: swalker@.com"
  end

  def test_email_valid_without_domain
    assert_equal true, @email_witho_domain.valid('swalker@walkertek.com'), "Testing: swalker@walkertek.com"
    assert_equal true, @email_witho_domain.valid('swalker@blackboxweb.com'), "Testing: swalker@blackboxweb.com"
    assert_equal true, @email_witho_domain.valid('swalker@blackbox.us'), "Testing: swalker@blackbox.us"
    assert_equal true, @email_witho_domain.valid('swalker@walkertek1.com'), "Testing: swalker@com"
    assert_equal false, @email_witho_domain.valid('swalker@'), "Testing: swalker@"
  end
end

