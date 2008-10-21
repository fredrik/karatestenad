class WordsController < ApplicationController
  # GET /words
  # GET /words.xml
  def index
    @words = Word.find(:all)
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @words }
    end
  end

  # GET /words/1
  # GET /words/1.xml
  def show
    @word = Word.find_by_normalized_word(params[:id])

    respond_to do |format|
      if @word.nil?
        @word = Word.new
        @word.word = params[:id]
        format.html { render :action => 'new'}
      else
        format.html # show.html.erb
        format.xml  { render :xml => @word }
      end
    end
  end

  # GET /words/new
  # GET /words/new.xml
  def new
    @word = Word.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @word }
    end
  end

  # GET /words/1/edit
  def edit
    @word = Word.find_by_normalized_word(params[:id])
  end

  # POST /words
  # POST /words.xml
  def create
    @word = Word.new(params[:word])

    respond_to do |format|
      if params[:preview]
        flash[:notice] = 'PREVIEW MODE: ENABLED.'
        @preview = @word.to_html
        format.html { render :action => 'new' }
      elsif @word.save
        flash[:notice] = 'un succès!'
        format.html { redirect_to(@word) }
        format.xml  { render :xml => @word, :status => :created, :location => @word }
      else
        # is this really what I want?
        format.html { render :action => "new" }
        format.xml  { render :xml => @word.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /words/1
  # PUT /words/1.xml
  def update
    @word = Word.find_by_normalized_word(params[:id])

    respond_to do |format|
      if params[:preview]
        flash[:notice] = 'PREVIEW MODE: ENABLED.'
        @word.definition = params[:word][:definition]
        @preview = @word.to_html
        format.html { render :action => "edit" }
        format.xml  { render :xml => @word.errors, :status => :unprocessable_entity } # well..
      elsif @word.update_attributes(params[:word])
        # TODO: may not change word (and thus, may not change normalized_word)
        flash[:notice] = 'un succès!'
        format.html { redirect_to(@word) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @word.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /words/1
  # DELETE /words/1.xml
  #def destroy
  #  @word = Word.find(params[:id])
  #  @word.destroy

  #  respond_to do |format|
  #    format.html { redirect_to(words_url) }
  #    format.xml  { head :ok }
  #  end
  #end
end
