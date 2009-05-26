class FlexifieldDefsController < ApplicationController
  
  before_filter :find_flexifield_def, :only => %w(show edit update destroy)

  helper_method :setup_flexifield_def

  # GET /flexifield_defs
  # GET /flexifield_defs.xml
  def index
    @flexifield_defs = FlexifieldDef.all :include => :flexifield_def_entries

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @flexifield_defs }
    end
  end

  # GET /flexifield_defs/1
  # GET /flexifield_defs/1.xml
  def show
    @flexifield_def = FlexifieldDef.find(params[:id],  :include => :flexifield_def_entries)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @flexifield_def }
    end
  end

  # GET /flexifield_defs/new
  # GET /flexifield_defs/new.xml
  def new
    @flexifield_def = FlexifieldDef.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @flexifield_def }
    end
  end

  # GET /flexifield_defs/1/edit
  def edit
  end

  # POST /flexifield_defs
  # POST /flexifield_defs.xml
  def create
    @flexifield_def = FlexifieldDef.new(params[:flexifield_def])

    respond_to do |format|
      if @flexifield_def.save
        flash[:notice] = 'FlexifieldDef was successfully created.'
        format.html { redirect_to(@flexifield_def) } #flexifield_defs_url
        format.xml  { render :xml => @flexifield_def, :status => :created, :location => @flexifield_def }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @flexifield_def.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /flexifield_defs/1
  # PUT /flexifield_defs/1.xml
  def update
    respond_to do |format|
      if @flexifield_def.update_attributes(params[:flexifield_def])
        flash[:notice] = 'FlexifieldDef was successfully updated.'
        format.html { redirect_to(@flexifield_def) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @flexifield_def.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /flexifield_defs/1
  # DELETE /flexifield_defs/1.xml
  def destroy
    @flexifield_def.destroy

    respond_to do |format|
      format.html { redirect_to(flexifield_defs_url) }
      format.xml  { head :ok }
    end
  end

  def setup_flexifield_def(flexifield_def)
    returning(flexifield_def) do |ffd|
      if ffd.flexifield_def_entries.empty?
        ffd.flexifield_def_entries.build
      end
      if !ffd.flexifield_def_entries.last.id.blank? && ffd.flexifield_def_entries.length < Flexifield.flexiblefield_names_count
        ffd.flexifield_def_entries << FlexifieldDefEntry.new()
      end
    end
  end

  private
  
  def find_flexifield_def
    @flexifield_def = FlexifieldDef.find(params[:id],  :include => :flexifield_def_entries)
  end
end
