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

      def create_ff_tables!
        self.connection.create_table :flexifields do |t|
          t.integer :flexifield_def_id
          t.integer :flexifield_set_id
          t.string  :flexifield_set_type
          t.timestamps
          1.upto(16) {|i| t.string "ffs_" + (i < 10 ? "0#{i}" : "#{i}")}
          
        end
        
        self.connection.create_table :flexifield_defs do |t|
          t.string      :name, :null => false
          t.timestamps
        end

        self.connection.create_table :flexifield_def_entries do |t|
          t.integer     :flexifield_def_id, :null => false
          t.string      :flexifield_name, :null => false
          t.string      :flexifield_alias, :null => false
          t.integer     :ordering
          t.timestamps
        end

        self.connection.add_index :flexifields, [:flexifield_set_id, :flexifield_set_type], :name => 'idx_ff_poly'
        self.connection.add_index :flexifields, :flexifield_def_id

        self.connection.add_index :flexifield_def_entries, [:flexifield_def_id, :ordering], :name => 'idx_ffde_ordering'
        self.connection.add_index :flexifield_def_entries, [:flexifield_def_id, :flexifield_name], :name => 'idx_ffde_onceperdef', :unique => true

      end
      
      def drop_ff_tables!
        self.connection.drop_table :flexifield_def_entries
        self.connection.drop_table :flexifield_def
        self.connection.drop_table :flexifields
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