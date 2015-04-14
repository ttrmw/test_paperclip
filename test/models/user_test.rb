require 'rake'
require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do 
    User.has_thumb = false 
  end 

  test 'can create dummy user' do 
    assert_difference 'User.all.count', 1 do 
      User.create_dummy_user!
    end
  end 

  test 'dummy user is created with avatar' do 
    user = User.create_dummy_user!
    assert_not_nil user.avatar_file_name
  end 

  test 'can create one hundred dummy users' do 
    assert_difference 'User.all.count', 100 do 
      User.create_one_hundred_dummy_users!
    end
  end

  test 'can create five hundred dummy users' do 
    assert_difference 'User.all.count', 500 do 
      User.create_five_hundred_dummy_users! 
    end 
  end

  test 'Has thumb defaults to false' do 
    assert_equal false, User.has_thumb?
  end

  test 'Has thumb can be updated' do
    assert_equal false, User.has_thumb? 
    User.has_thumb = true 
    assert_equal true, User.has_thumb?
  end

  test 'Style returns nil if User does not have thumb' do 
    assert_equal false, User.has_thumb?
    assert_equal( {}, User.paperclip_styles ) 
  end

  test 'Style returns thumb if User has thumb' do 
    User.has_thumb = true 
    assert_equal( { thumb: '100x100>' }, User.paperclip_styles )
  end

end


