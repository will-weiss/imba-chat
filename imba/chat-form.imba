var ENTER_KEY = 13

# A message input is a text input for a user to input text for a message.
tag message-input < input

	attr type
	attr placeholder

	def render
		<self id="message-input" type='text' placeholder='Type a message to send'>

	# Submit a message by sending the value of the input to the chat and clearing
	# the existing value.
	def submit
		var chat = @object
		chat.send value
		value = ''

	# Monitor keydown events, submitting the messate text if the enter key is
	# down.
	def onkeydown e
		submit if e.which == ENTER_KEY


# A chat form is the footer consisting of the message input and a button which
# sends the message when clicked.
tag chat-form

	def render
		var chat = @object
		<self id="chat-form">
			<message-input[chat]>
			<button :tap='submit'> 'Send'

	# Submit a message by having the message input send its message.
	def submit
		#message-input.submit
