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
      format.html # show.html.erb
      format.xml  { render :xml => @word }
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
    params[:word]["normalized_word"] = Word.normalize_word params[:word]['word']
    # todo: check uniquness of normalized_word (in model, right?)
    @word = Word.new(params[:word])

    respond_to do |format|
      if @word.save
        flash[:notice] = 'un succès!'
        format.html { redirect_to(@word) }
        format.xml  { render :xml => @word, :status => :created, :location => @word }
      else
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
      # TODO: may not change word (and thus, may not change normalized_word)
      if @word.update_attributes(params[:word])
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
