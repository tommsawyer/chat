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

	showClientInfo: (client, data) ->
		if data.id
			cl = @server.getClientById data.id
			return cl.getInfo() unless cl == null
		client.getInfo()


module.exports = System