var io = require('socket.io-client')
var socket = io()

var ENTER_KEY = 13

var BriBri = User.new('Brian', 'http://media2.giphy.com/media/8KrhxtEsrdhD2/giphy.gif')
var OuiOui = User.new('Will', 'http://ak-hdl.buzzfed.com/static/2015-08/20/14/enhanced/webdr07/anigif_enhanced-1164-1440095680-3.gif')

var activeChat = Chat.new(BriBri, OuiOui)

class User
	prop name
	prop avatar

	def initialize name, avatar
		@name = name
		@avatar = avatar

class Chat
	prop me
	prop them
	prop messages

	def initialize me, them
		@me = me
		@them = them
		@messages = []
		socket.on 'chat message', do |message|
			receive message

	def send message
		return unless message
		socket.emit('chat message', message)
		ChatMessage.new(self, @me, message)

	def receive message
		return unless message
		ChatMessage.new(self, @them, message)

class ChatMessage
	prop user
	prop message

	def initialize chat, user, message
		@user = user
		@message = message
		chat.messages.push self
		#message-list.render

tag avatar < img
	def render
		var user = @object
		<self src=user.avatar>

tag message-row < li
	def render
		var message = @object
		<self>
			<p> "{message.user.name}: {message.message}"
			<avatar[message.user]>

tag message-list < ul
	def render
		<self id='message-list'>
			<message-row[message]> for message in activeChat.messages

tag message-input < input
	def submit
		activeChat.send value
		value = ''

	def onkeydown e
		submit if e.which == ENTER_KEY

tag chat-form
	def submit
		#message-input.submit

	def render
		<self id="chat-form">
			<message-input id="message-input" type='text' placeholder='Type a message to send'>
			<button :tap='submit'> 'Send'

tag #app
	def render
		<self>
			<message-list>
			<chat-form>

# append it to the dom
$$(.chatapp).append #app
