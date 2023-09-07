class_name HighScore
extends ItemList

# http://dreamlo.com/lb/abcd
# Private: abcd
# Public: abcd

const PRIVATE_URL = "http://dreamlo.com/lb/abcd"
const PUBLIC_URL = "http://dreamlo.com/lb/abcd"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func update_list():
	print("Trying to fetch leaderboard")
	
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(self._http_request_completed)

	# Perform a GET request. The URL below returns JSON as of writing.
	var error = http_request.request(PUBLIC_URL + "/json/10")
	if error != OK:
		push_error("An error occurred in the HTTP request.")

# Called when the HTTP request is completed.
func _http_request_completed(_result, response_code, headers, body):
	if response_code == 200 and "Content-Type: application/json; charset=utf-8" in headers:
		var json = JSON.new()
		json.parse(body.get_string_from_utf8())
		var response = json.get_data()
		if "dreamlo" in response and "leaderboard" in response["dreamlo"] and response["dreamlo"]["leaderboard"]:
			clear()
			var place = 1
			var entries = response["dreamlo"]["leaderboard"]["entry"]
			
			# Omg, if only one result, then a list is not returned
			if entries is Dictionary:
				entries = [entries]
				
			for entry in entries:
				add_item("%d: %s" % [place, entry["name"].uri_decode()])
				add_item(entry["score"])
				place += 1


func _on_highscore_visibility_changed():
	if $"../..".is_visible_in_tree():
		$"../../../BackButton".grab_focus()
