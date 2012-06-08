$('#contact_form_container').hide('clip', 500, ->
	$(this)
		.html('<p id="sent_message">Message sent.<span>I will get back to you as soon as I can.</span></p>')
		.show('clip', 500)
)