# An avatar tag renders a 50x50 avatar.
tag avatar < img

	attr style

	def render
		var src = @object
		<self src=src style='width: 50px; height: 50px;'>

# A message row consists of the name of the user who sent the message, the text
# of the message, and the avatar of the user.
tag message-row < li

	def render
		var message = @object
		var user = message.user
		<self>
			<p> "{user.name}: {message.text}"
			<avatar[user.avatarSrc]>

# A message list consists of the messages of a chat.
tag message-list < ul

	def render
		var messages = @object
		<self id='message-list'>
			<message-row[message]> for message in messages
