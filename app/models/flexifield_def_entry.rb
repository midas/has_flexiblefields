class FlexifieldDefEntry < ActiveRecord::Base
  belongs_to :flexifield_def
  validates_presence_of :flexifield_name, :flexifield_alias, :flexifield_order
  
  before_save :ensure_alias_is_one_word
  
  ViewColumn = Struct.new(:object,:content) do
    def viewname
      object.name.gsub(/flexifield_/,"").titleize
    end
    def field
      object.name.to_sym
    end
  end
  
  def self.view_columns
    columns.map{|c| ViewColumn.new(c) if [:integer,:string,:text].member?(c.type) && c.name =~ /flexifield_(?!.+_id)/}.compact
  end
  
  def self.wrap_form_columns(form_for)
    returning view_columns do |a|
      a.each do |c|
        case c.field
          when :flexifield_alias
            c.content= form_for.text_field(c.field)
          when :flexifield_name
            c.content= form_for.select(c.field, Flexifield.flexiblefield_names)
          when :flexifield_tooltip
            c.content= form_for.text_area(c.field, :cols => 80, :rows => 6)
          when :flexifield_order
            c.content= form_for.select(c.field, (1..32).to_a)
        end
      end
    end
  end
  
  def self.wrap_viewable_columns(css, lastcss)
    returning view_columns do |a|
      a[0..-2].each do |c|
        c.content= css
      end
      a.last.content= lastcss
    end
  end

  def to_ff_field ff_alias = nil
    (ff_alias.nil? || flexifield_alias == ff_alias) ? flexifield_name : nil
  end
  def to_ff_alias ff_field = nil
    (ff_field.nil? || flexifield_name == ff_field) ? flexifield_alias : nil
  end
  
  private

  def ensure_alias_is_one_word
    flexifield_alias.gsub!(/\s+/,"_")
  end
  
  
  
end
