class Client
	constructor: (@id, @ws) ->
		@inSearch = true
	func: ->
		@inSearch

	sendMessage: (msg) ->
		@ws.send(msg)

	startSearch: ->
		@inSearch = true unless @inSearch

	exitRoom: ->
		return false unless @room

module.exports = Client