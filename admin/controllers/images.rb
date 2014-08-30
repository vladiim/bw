Bw::Admin.controllers :images do
  get :index do
    @title = "Images"
    @images = Image.all
    render 'images/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'image')
    @image = Image.new
    render 'images/new'
  end

  post :create do
    @image = Image.new(params[:image])
    # require 'debugger'; debugger
    if (@image.upload! rescue false)
      @title = pat(:create_title, :model => "image #{@image.id}")
      flash[:success] = pat(:create_success, :model => 'Image')
      params[:save_and_continue] ? redirect(url(:images, :index)) : redirect(url(:images, :edit, :id => @image.id))
    else
      @title = pat(:create_title, :model => 'image')
      flash.now[:error] = pat(:create_error, :model => 'image')
      render 'images/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "image #{params[:id]}")
    @image = Image[params[:id]]
    if @image
      render 'images/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'image', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "image #{params[:id]}")
    @image = Image[params[:id]]
    if @image
      if @image.modified! && @image.update(params[:image])
        flash[:success] = pat(:update_success, :model => 'Image', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:images, :index)) :
          redirect(url(:images, :edit, :id => @image.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'image')
        render 'images/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'image', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Images"
    image = Image[params[:id]]
    if image
      if image.destroy
        flash[:success] = pat(:delete_success, :model => 'Image', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'image')
      end
      redirect url(:images, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'image', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Images"
    unless params[:image_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'image')
      redirect(url(:images, :index))
    end
    ids = params[:image_ids].split(',').map(&:strip)
    images = Image.where(:id => ids)
    
    if images.destroy
    
      flash[:success] = pat(:destroy_many_success, :model => 'Images', :ids => "#{ids.to_sentence}")
    end
    redirect url(:images, :index)
  end
end
