require('./chat-form')
var Chat = require('./chat')
var User = require('./user')

# Create some users, supplying their names and avatars.
var weiss = User.new('Weiss', 'http://media2.giphy.com/media/8KrhxtEsrdhD2/giphy.gif')
var brian = User.new('Brian', 'http://ak-hdl.buzzfed.com/static/2015-08/20/14/enhanced/webdr07/anigif_enhanced-1164-1440095680-3.gif')

# Create an active chat between the two users.
var activeChat = Chat.new(weiss, brian)

# The app consists of the message list and the chat form.
tag #app

	def render
		<self>
			<message-list[activeChat.messages]>
			<chat-form[activeChat]>

# Append the app to the dom.
$$(.chatapp).append #app
