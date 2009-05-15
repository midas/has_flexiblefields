class FlexifieldDef < ActiveRecord::Base

  has_many :flexifield_def_entries, :class_name => 'FlexifieldDefEntry', :order => 'ordering', :dependent => :destroy
  accepts_nested_attributes_for :flexifield_def_entries
  
  def to_ff_field ff_alias
    idx = nil
    ff_aliases.each_with_index do |c,i|
      idx = i if c == ff_alias
    end
    idx ? flexifield_def_entries[idx].to_ff_field : nil
  end

  def to_ff_alias ff_field
    idx = nil
    ff_fields.each_with_index do |c,i|
      idx = i if c == ff_field
    end
    idx ? flexifield_def_entries[idx].to_ff_alias : nil
  end
  
  def ff_aliases
    flexifield_def_entries.nil? ? [] : flexifield_def_entries.map(&:flexifield_alias)
  end

  def ff_fields
    flexifield_def_entries.nil? ? [] : flexifield_def_entries.map(&:flexifield_name)
  end
  
  
end
