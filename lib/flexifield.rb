# To change this template, choose Tools | Templates
# and open the template in the editor.

class Flexifield < ActiveRecord::Base

  belongs_to :flexifield_set, :polymorphic => true
  belongs_to :flexifield_def, :include => 'flexifield_def_entries'

  delegate :to_ff_alias, :to_ff_field, :ff_aliases, :ff_fields, :to => :flexifield_def
  
  def ff_alias_value ff_alias
    ff_field = to_ff_field ff_alias
    if ff_field
      send ff_field
    else
      raise ArgumentError, "Flexifield alias: #{ff_alias} not found in flexifeld def mapping"
    end
    
  end

end
