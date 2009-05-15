class FlexifieldDefEntry < ActiveRecord::Base
  belongs_to :flexifield_def
  validates_presence_of :flexifield_name, :flexifield_alias
  
  def to_ff_field ff_alias = nil
    (ff_alias.nil? || flexifield_alias == ff_alias) ? flexifield_name : nil
  end
  def to_ff_alias ff_field = nil
    (ff_field.nil? || flexifield_name == ff_field) ? flexifield_alias : nil
  end
  
  
end
