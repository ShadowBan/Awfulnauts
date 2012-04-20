#8bitURL.rb

### CONTROLLER ACTIONS

layout :layout

#Home Page
get '/' do
#  @gamebreaker = Rss.get_gamebreaker
#  @darth_cast = Rss.get_darthhater_cast

  @gamebreaker = Rss.get_feed('gamebreaker')
  @darth_cast = Rss.get_feed('darthhater_cast')
  @darthhater = Rss.get_feed('darthhater')
  @devtracker = Rss.get_feed('devtracker')
  @guild_twitter = Rss.get_feed('guild_twitter')
  @guild_reddit = Rss.get_feed('guild_reddit')
  @swtor_reddit = Rss.get_feed('swtor_reddit')
  haml :index
end

get '/error' do
  raise
end

get '/photo-test' do
  haml :slideshow
end

get '/sk' do
  @lists = Sk.get_current
  haml :sk
end

get '/sk/list/:pub_id/:pvt_id' do
  @list,@owner = Sk.get_list(params[:pub_id],params[:pvt_id])
  @list_id = params[:pub_id]
  @owner_id = params[:pvt_id]

  if @list
    haml :sk_list
  else
    redirect '/sk'
  end
end

get '/sk/list/:pub_id' do
  @list,@owner = Sk.get_list(params[:pub_id])
  if @list
    haml :sk_list
  else
    redirect '/sk'
  end
end

get '/sk/create_list' do
  list_id,owner_id = Sk.create_list
  redirect "/sk/list/#{list_id}/#{owner_id}"
end

post '/sk/:pub_id/add-raider' do
  Sk.add_raider(params[:pub_id],params[:name])
  redirect back
end

get '/sk/:pub_id/remove-raider/:name' do
  Sk.remove_raider(params[:pub_id],params[:name])
  redirect back
end

get '/sk/:pub_id/get-loot/:name' do
  Sk.get_loot(params[:pub_id],params[:name])
  redirect back
end

get '/expire' do
  Rss.expire_cache
  redirect '/'
end
