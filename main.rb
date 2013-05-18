require 'sinatra'
require 'slim'
require 'data_mapper'
$listed = 0

get '/' do
	slim :index
end

get '/login' do
	slim :login
end

get '/fail_login' do
	slim :fail_login
end

get '/backstage' do
	slim :backstage
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
