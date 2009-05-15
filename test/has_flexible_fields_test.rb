require 'test_helper'

class HasFlexibleFieldsTest < ActiveSupport::TestCase
  fixtures :flexifield_defs, :flexifield_def_entries

  #this is so the test rig can have :memory: or file db and self.use_transactional_fixtures = true or false
  def get_post assign_def = false
    if Post.count > 0
      returning Post.last do |post|
        post.assign_ff_def FlexifieldDef.first.id if assign_def
      end
    else
      returning Post.create!(:title => 'title1', :body => 'body1') do |post|
        post.assign_ff_def FlexifieldDef.first.id if assign_def
      end
    end
  end
  
  def test_a_new_post_has_no_ff_def
    post = get_post
    assert !post.new_record?
    assert !post.has_ff_def?
  end
  
  def test_b_new_post_saves_def
    post = get_post(true)
    assert post.has_ff_def?
  end

  def test_c_new_post_ff_aliases
    post = get_post(true)
    assert_equal ['excerpt','references'], post.ff_aliases
  end
  
  def test_d_new_post_ff_fields
    post = get_post(true)
    assert_equal ['ffs_01','ffs_02'], post.ff_fields
  end
  
  def test_c_new_post_to_ff_alias
    post = get_post(true)
    assert_equal 'excerpt', post.to_ff_alias('ffs_01')
  end
  
  def test_d_new_post_to_ff_field
    post = get_post(true)
    assert_equal 'ffs_02', post.to_ff_field('references')
  end
  
  
end
