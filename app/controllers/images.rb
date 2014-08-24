Bw::App.controllers :images do
  
  # get :index, :map => '/foo/bar' do
  #   session[:foo] = 'bar'
  #   render 'index'
  # end

  # get :sample, :map => '/sample/url', :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   'Maps to url '/foo/#{params[:id]}''
  # end

  # get '/example' do
  #   'Hello world!'
  # end
  
  get :new do
    render 'images/new'
  end

  post :create do
    image_data = params.fetch('image')
    title = image_data.fetch('title')
    # require 'debugger'; debugger
    file = image_data.fetch('file')
    @image = Image.new
    @image.upload!(title, file)
  end

end
