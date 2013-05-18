require 'sinatra'
require 'slim'
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
	if $listed == 1
		slim :backstage
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
