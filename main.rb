require 'sinatra'
require 'slim'
require 'data_mapper'
require 'sass'
DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/articles.db")    #这句也不能忘啊！！！
$listed = 0
$mode = 0

class Article
	include DataMapper::Resource
	property :id, Serial
	property :title, String, :required => true
	property :content, Text
	property :visitors, Integer, :required => true
	property :write_at, DateTime, :required => true
end

DataMapper.finalize   #这句千万别忘啊！！！！！

get '/' do
	@articles = Article.all(:order => [:id])
	slim :index
end

get '/content/:id' do
	@id = params[:id].to_i
	@article = Article.get(@id)
	@visitors = Article.get(@id).visitors
	slim :content
end

get '/login' do
	slim :login
end

get '/fail_login' do
	slim :fail_login
end

get '/backstage' do
	if $listed == 1
		@articles = Article.all(:order => [:id])
		slim :backstage
	else
		slim :not_login
	end
end

get '/edit' do
	if $listed == 1
		@title = ''
		@content = ''
		slim :edit
	else
		slim :not_login
	end
end

get '/delete/:id' do
	Article.get(params[:id].to_i).destroy
	redirect '/backstage'
end

get '/edit/:id' do
	if $listed == 1
		@id = params[:id].to_i
		@title = Article.get(params[:id].to_i).title
		@content = Article.get(params[:id].to_i).content
		$mode = 1
		slim :edit
	else
		slim :not_login
	end
end

get '/logout' do
	$listed = 0
	redirect '/'
end

post '/login' do
	if params[:password] == '1992huxu'
		$listed = 1
		redirect '/backstage'
	else
		redirect '/fail_login'
	end
end

post '/edit/:id' do
	Article.get(params[:id].to_i).update(title: params[:title], content: params[:content], write_at: Time.now)
	$mode = 0
	redirect '/backstage'
end

post '/edit' do
	Article.create(title: params[:title], content: params[:content], visitors: 1, write_at: Time.now)
	redirect '/backstage'
end
