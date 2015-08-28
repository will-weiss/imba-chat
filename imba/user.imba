# A user has a name, and a url source for their avatar.
class User

	prop name
	prop avatarSrc

	def initialize name, avatarSrc
		@name = name
		@avatarSrc = avatarSrc

module.exports = User
