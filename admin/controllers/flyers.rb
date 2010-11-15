Admin.controllers :flyers do

  get :index do
    @flyers = Flyer.all
    render 'flyers/index'
  end

  get :new do
    @flyer = Flyer.new
    render 'flyers/new'
  end

  post :create do
    if params[:flyer][:file_name].empty?
      @flyer = Flyer.new(:file_name => params[:flyer][:file][:filename], :account_ids => [])
    else
      @flyer = Flyer.new(:file_name => params[:flyer][:file_name], :account_ids => [])
    end
    if @flyer.save
      # save attachement if there was a file uploaded
      if params[:flyer][:file]
        @flyer.create_attachment(:file => params[:flyer][:file][:tempfile], :name => params[:flyer][:file][:filename])
        @flyer.save
        if @flyer.save
          flash[:notice] = 'Flyer was successfully created. (with file)'
          redirect url(:flyers, :edit, :id => @flyer.id)
        else
          render 'flyers/new'
        end          
      else
        flash[:notice] = 'Flyer was successfully created. (without file)'
        redirect url(:flyers, :edit, :id => @flyer.id)
      end
    else
      render 'flyers/new'
    end
  end

  get :edit, :with => :id do
    @flyer = Flyer.get(params[:id])
    @accounts = Account.by_role_name(:raw => true, :key => "user")["rows"]
    render 'flyers/edit'
  end

  put :update, :with => :id do
    account_ids = params[:flyer][:account_ids].split(",").collect{|x| x if x != ""}.compact
    p account_ids
    @flyer = Flyer.get(params[:id])
    if @flyer.update_attributes(:file_name => params[:flyer][:file_name], :account_ids => account_ids)
      # save attachement if there was a file uploaded
      if params[:flyer][:file]
        # delete existing attachment
        @flyer["_attachments"].delete @flyer["_attachments"].keys.first unless @flyer["_attachments"].nil?
        @flyer.save
        # attache new file
        @flyer.create_attachment(:file => params[:flyer][:file][:tempfile], :name => params[:flyer][:file][:filename])
        @flyer.save
        if @flyer.save
          flash[:notice] = 'Flyer was successfully updated. (new file)'
          redirect url(:flyers, :edit, :id => @flyer.id)
        else
          flash[:error] = 'Flyer failed to updated. try again'
          redirect url(:flyers, :edit, :id => @flyer.id)
        end          
      else
        flash[:notice] = 'Flyer was successfully updated. (same file)'
        redirect url(:flyers, :edit, :id => @flyer.id)
      end
    else
      flash[:error] = 'Flyer failed to updated. try again'
      redirect url(:flyers, :edit, :id => @flyer.id)
    end
  end

  get :attachment, :with => [:id,:filename] do
    @flyer = Flyer.get(params[:id])
    content_type "application/octet-stream"
    Base64.decode64(@flyer.read_attachment(@flyer["_attachments"].keys.first))
  end

  delete :destroy, :with => :id do
    flyer = Flyer.get(params[:id])
    if flyer.destroy
      flash[:notice] = 'Flyer was successfully destroyed.'
    else
      flash[:error] = 'Impossible destroy Flyer!'
    end
    redirect url(:flyers, :index)
  end
  
end