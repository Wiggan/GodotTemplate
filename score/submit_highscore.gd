extends HBoxContainer
@onready var line_edit = $LineEdit


func _on_submit_button_pressed():
	Config.set_config_parameter("nickname", line_edit.text)
	print("Submitting score!")
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(self._http_request_completed)

	var error = http_request.request(HighScore.PRIVATE_URL + "/add/" + line_edit.text.uri_encode() + "/" + str(GameManager.game_state["Score"]))
	if error != OK:
		push_error("An error occurred in the HTTP request.")
		$Failed.play()
	

# Called when the HTTP request is completed.
func _http_request_completed(_result, response_code, _headers, body):
	var body_as_text = body.get_string_from_utf8()
	print(body_as_text)
	if response_code == 200 and "Error" not in body_as_text:
		$"../ItemList".update_list()
		$SubmitButton.disabled = true
		$Success.play()
	else:
		push_error(_result, _headers, body_as_text)
		$Failed.play()
