class Client
	constructor: (@id, @ws) ->

	sendMessage: (msg) ->
		@ws.send(msg)

module.exports = Client