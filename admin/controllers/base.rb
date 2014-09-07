Bw::Admin.controllers :base do
  get :index, :map => "/" do
    @title = "Articles"
    @articles = Article.all
    render "articles/index"
  end
end
