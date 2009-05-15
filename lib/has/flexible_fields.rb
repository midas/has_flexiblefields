# Has FlexibleFields
#
# Copyright (c) 2009 Guy Boertje <gboertje AT gowebtop DOT com>
# see README for license
module Has #:nodoc:
  module FlexibleFields #:nodoc:



    def self.included(base) # :nodoc:
      base.extend ClassMethods
    end

    module ClassMethods
      def has_flexiblefields options = {}
        unless includes_flexiblefields?
          
          has_one :flexifield, :as => :flexifield_set, :dependent => :destroy
          delegate :ff_alias_value, :to_ff_alias, :ff_aliases, :to_ff_field, :ff_fields, :to => :flexifield
          
          accepts_nested_attributes_for :flexifield
          
          after_create :create_flexifield
          after_save :save_flexifield
          
#          if options[:some_option]
#
#          end

        end

        include InstanceMethods

      end
      def includes_flexiblefields?
        self.included_modules.include?(InstanceMethods)
      end
    end
    
    module InstanceMethods
      def has_ff_def?
        flexifield.nil? ? false : !flexifield.flexifield_def_id.nil?
      end
      
      def assign_ff_def ff_def_id
        self.flexifield.flexifield_def_id = ff_def_id
        save_flexifield
      end
      
      def assign_ff_value ff_alias, value
        ff_field = to_ff_field ff_alias
        if ff_field
          self.flexifield.send "#{ff_field}=", value
          save_flexifield
        else
          raise ArgumentError, "Flexifield alias: #{ff_alias} not found in flexifeld def mapping"
        end 
      end
      
      protected
      
      def save_flexifield
        self.flexifield.save
      end
      
      def create_flexifield
        self.flexifield = Flexifield.new()
      end
      
    end
  end
end