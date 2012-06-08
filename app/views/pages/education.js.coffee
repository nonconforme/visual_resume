$("#page").html("<%= escape_javascript(render(:template => "pages/education", :formats => :html)) %>").show()
$('.row1', '#education_content').show('slide', {direction: 'right'}, 1000, ->
	$('.row2', '#education_content').show('slide', {direction: 'up', easing: 'easeOutBounce'}, 1000, ->
		$('.row3', '#education_content').show('slide', {direction: 'up', easing: 'easeOutBounce'}, 1000)	
	)
)

document.title = "Nick J. Reed | Education"
window.initTooltip()