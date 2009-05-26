class FlexifieldDefEntriesController < ApplicationController
  
  before_filter :get_flexifield_def
  before_filter :find_flexifield_def_entry, :only => %w(show update destroy)

  layout 'flexifield_defs'

  # GET /flexifield_defs/:flexifield_def_id/flexifield_def_entries
  # GET /flexifield_defs/:flexifield_def_id/flexifield_def_entries.xml
  def index
    @flexifield_def_entries = @flexifield_def.flexifield_def_entries.find(:all)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @flexifield_def_entries }
    end
  end

  # GET /flexifield_defs/:flexifield_def_id/flexifield_def_entries/1
  # GET /flexifield_defs/:flexifield_def_id/flexifield_def_entries/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @flexifield_def_entry }
    end
  end

  # GET /flexifield_defs/:flexifield_def_id/flexifield_def_entries/new
  # GET /flexifield_defs/:flexifield_def_id/flexifield_def_entries/new.xml
  def new
    @flexifield_def_entry = @flexifield_def.flexifield_def_entries.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @flexifield_def_entry }
    end
  end
  
  # GET /flexifield_defs/:flexifield_def_id/flexifield_def_entries/1/edit
  def edit
  end

  # POST /flexifield_defs/:flexifield_def_id/flexifield_def_entries
  # POST /flexifield_defs/:flexifield_def_id/flexifield_def_entries.xml
  def create
    @flexifield_def_entry = @flexifield_def.flexifield_def_entries.new(params[:flexifield_def_entry])
    respond_to do |format|
      if @flexifield_def_entry.save
        flash[:notice] = 'FlexifieldDefEntry was successfully created.'
        format.html { redirect_to(@flexifield_def_entry) }
        format.xml  { render :xml => @flexifield_def_entry, :status => :created, :location => @flexifield_def_entry }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @flexifield_def_entry.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /flexifield_defs/:flexifield_def_id/flexifield_def_entries/1
  # PUT /flexifield_defs/:flexifield_def_id/flexifield_def_entries/1.xml
  def update
    respond_to do |format|
      if @flexifield_def_entry.update_attributes(params[:flexifield_def_entry])
        flash[:notice] = 'FlexifieldDefEntry was successfully updated.'
        format.html { redirect_to(@flexifield_def_entry) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @flexifield_def_entry.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /flexifield_defs/:flexifield_def_id/flexifield_def_entries/1
  # DELETE /flexifield_defs/:flexifield_def_id/flexifield_def_entries/1.xml
  def destroy
    @flexifield_def_entry.destroy
    respond_to do |format|
      format.html { redirect_to(flexifield_def_entries_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def find_flexifield_def_entry
    get_flexifield_def unless @flexifield_def
    @flexifield_def_entry = @flexifield_def.flexifield_def_entries.find(params[:id])
  end
  
  def get_flexifield_def
    @flexifield_def = FlexifieldDef.find(params[:flexifield_def_id])
  end
  
end
