extends Control


var string = "user://pack.pck"
var loaded = false
var pck = null
var timeout = false
var url = "https://github.com/sreeranj-developer/conjunction-server/releases/download/test-1/pack.pck"

func load_scene():
	pck = ProjectSettings.load_resource_pack(string)
	if pck:
		var scene = load("res://scenes/levels/level_1.tscn")
		get_tree().change_scene_to_packed(scene)

func _ready():
	$HTTPRequest.set_download_file(string)
	$HTTPRequest.request(url)

func _process(delta):
	var arr = float($HTTPRequest.get_downloaded_bytes()/1024)
	var total = float($HTTPRequest.get_body_size()/1024)
	$TextureProgressBar.value = (arr/total) * 100
	if ($HTTPRequest.get_http_client_status()) == 0 and $TextureProgressBar.value == 0:
		$Label2.show()
	else:
		$Label2.hide()
	if $TextureProgressBar.value == 100:
		$TextureProgressBar.hide()

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "new_animation":
		await get_tree().create_timer(3).timeout
		$AudioStreamPlayer.stop()
		$tansition.show()
		$tansition.play_out()
	if anim_name == "out":
		load_scene()

func _on_http_request_request_completed(result, response_code, headers, body):
	if response_code == 200:
		$AnimationPlayer.play("new_animation")
