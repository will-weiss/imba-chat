var io = require('socket.io-client')
var socket = io()

require('./message-list')

# A chat message consists of a user and the text of a message. On creation, a
# chat message pushes itself on the array of messages of the chat and results in
# the #message-list tag rendering.
class ChatMessage
	prop user
	prop text

	def initialize chat, user, text
		@user = user
		@text = text
		chat.messages.push self
		#message-list.render

# A chat consists of 'me', the user viewing the page, 'them', the user being
# conversed with, and an array of messages.
class Chat

	prop me
	prop them
	prop messages

	def initialize me, them
		@me = me
		@them = them
		@messages = []

		# Receive chat messages from the socket.
		socket.on 'chat message', do |message|
			receive message

	# Send a message by emitting the message to the socket and creating a new
	# chat message with me as the user.
	def send messageText
		return unless messageText
		socket.emit('chat message', messageText)
		ChatMessage.new(self, @me, messageText)

	# Receive a message by creating a new chat message with them as the user.
	def receive messageText
		return unless messageText
		ChatMessage.new(self, @them, messageText)

module.exports = Chat
