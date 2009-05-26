class FlexifieldDef < ActiveRecord::Base

  has_many :flexifield_def_entries, :class_name => 'FlexifieldDefEntry', :order => 'flexifield_order', :dependent => :destroy
  accepts_nested_attributes_for :flexifield_def_entries,
    :reject_if => proc { |attrs| attrs['flexifield_alias'].blank? }
  
  validates_presence_of :name
  
  #after_update :save_entries

  def to_ff_field ff_alias
    idx = nil
    ffa = "#{ff_alias}"
    ff_aliases.each_with_index do |c,i|
      idx = i if c == ffa
    end
    idx ? flexifield_def_entries[idx].to_ff_field : nil
  end

  def to_ff_alias ff_field
    idx = nil
    fff = "#{ff_field}" #make sure it is a string
    ff_fields.each_with_index do |c,i|
      idx = i if c == fff
    end
    idx ? flexifield_def_entries[idx].to_ff_alias : nil
  end
  
  def ff_aliases
    flexifield_def_entries.nil? ? [] : flexifield_def_entries.map(&:flexifield_alias)
  end

  def ff_fields
    flexifield_def_entries.nil? ? [] : flexifield_def_entries.map(&:flexifield_name)
  end
  
  def unassigned_flexifield_names
    Flexifield.flexiblefield_names - ff_fields
  end
  
  private
  
  def save_entries
    flexifield_def_entries.each do |entry|
      entry.save false
    end
  end
end
