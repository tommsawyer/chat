class System
	constructor: (@server) ->

	activeUsers: ->
		@server.clients.map (client) ->
			return {
				id: client.id,
				name: client.getNickname()
			}
	changeNickname: (client, data) ->
		client.setNickname data


module.exports = System