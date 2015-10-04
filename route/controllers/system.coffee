class System
	constructor: (@server) ->

	activeUsers: ->
		do @server.activeClients

module.exports = System