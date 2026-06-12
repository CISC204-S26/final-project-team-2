# NetworkManager.gd
extends Node

const PORT = 7777
const MAX_CLIENTS = 1

var peer: ENetMultiplayerPeer = null
var is_host := false

signal player_connected
signal player_disconnected

func host_game():
	peer = ENetMultiplayerPeer.new()
	peer.create_server(PORT, MAX_CLIENTS)
	multiplayer.multiplayer_peer = peer
	is_host = true
	print("Hosting on port ", PORT)
	multiplayer.peer_connected.connect(_on_peer_connected)
	multiplayer.peer_disconnected.connect(_on_peer_disconnected)

func join_game(ip: String):
	peer = ENetMultiplayerPeer.new()
	peer.create_client(ip, PORT)
	multiplayer.multiplayer_peer = peer
	is_host = false
	print("Joining ", ip)
	multiplayer.peer_connected.connect(_on_peer_connected)
	multiplayer.peer_disconnected.connect(_on_peer_disconnected)

func _on_peer_connected(id: int):
	print("Peer connected: ", id)
	player_connected.emit()

func _on_peer_disconnected(id: int):
	print("Peer disconnected: ", id)
	player_disconnected.emit()
