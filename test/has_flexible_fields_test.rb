require 'test_helper'

class HasFlexibleFieldsTest < ActiveSupport::TestCase
  fixtures :flexifield_defs, :flexifield_def_entries
  
  #this is so the test rig can have :memory: or file db and self.use_transactional_fixtures = true or false
  def get_post assign_def = false
    if Post.count > 0
      returning Post.last do |post|
        post.ff_def= FlexifieldDef.first.id if assign_def
        yield post if block_given?
      end
    else
      returning Post.create!(:title => 'title1', :body => 'body1') do |post|
        post.ff_def= FlexifieldDef.first.id if assign_def
        yield post if block_given?
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
    assert_equal FlexifieldDef.first.id, post.ff_def
  end
  
  def test_c_new_post_ff_aliases
    post = get_post(true)
    assert_equal ['excerpt','references'], post.ff_aliases
  end
  
  def test_d_new_post_ff_fields
    post = get_post(true)
    assert_equal ['ffs_01','ffs_02'], post.ff_fields
  end
  
  def test_e_new_post_to_ff_alias
    post = get_post(true)
    assert_equal 'excerpt', post.to_ff_alias('ffs_01')
  end
  
  def test_f_new_post_to_ff_field
    post = get_post(true)
    assert_equal 'ffs_02', post.to_ff_field('references')
  end
  
  def test_g_new_post_write_values
    post = get_post(true)
    assert post.assign_ff_values({:excerpt => 'Some text', :references => 'Some references'})
  end
  
  def test_h_new_post_read_value
    post = get_post(true) do |p|
      p.assign_ff_values({:excerpt => 'Some text', :references => 'Some references'})
    end
    assert_equal 'Some text', post.get_ff_value(:excerpt)
    post.set_ff_value('references', "Other refs")
    assert_equal 'Other refs', post.get_ff_value('references')
  end
  
  def test_i_def_entry
    vcs = FlexifieldDefEntry.view_columns
    assert_equal FlexifieldDefEntry::ViewColumn, vcs.first.class
    assert_equal [], vcs.map(&:field) & [:id, :flexifield_def_id]
  end
  
end
