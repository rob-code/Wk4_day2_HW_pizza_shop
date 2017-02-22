require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require( './models/pizza.rb' )

# so what we are trying to do is get all the model commands from the controller

# READ - all
get '/pizzas' do       #pizzas is the web link
@pizzas = Pizza.all()   # has to be an instance variable so it can be accessed in the erb file
erb(:index)
end

# NEW - CREATE - request form and then return the form ... so its 2 steps. This has to be before :id because :id matches everything (because of the colon)

get '/pizzas/new' do
erb(:new)
end


# READ - find by ID
get '/pizzas/:id' do   #this is not a symbol, its a string which sinatra grabs as the key in the params class. If we require more than one key we can write this pizzas/:word/:another_word - this is a valid route
  @pizza = Pizza.find(params[:id])
  erb(:show)
end

# CREATE - submit form has all the data
post '/pizzas' do
# There's a sinatra function which reads the form values into params to make it just work 
@pizza = Pizza.new(params)
@pizza.save()
erb(:create)
end

# UPDATE - submit form

get '/pizzas/:id/edit' do
  @pizza = Pizza.find(params[:id])
  erb(:edit)
end

post '/pizzas/:id' do
  pizza = Pizza.new(params)
  pizza.update()
  redirect to "/pizzas/#{pizza.id}"
end



# DELETE
post '/pizzas/:id/delete' do
pizza = Pizza.find(params[:id])
pizza.delete()
redirect '/pizzas'
end
