$("#page").html("<%= escape_javascript(render(:template => "pages/portfolio", :formats => :html)) %>") unless window.initialLoad is 1
$('#sites').zAccordion(
	easing: "easeOutExpo"
	slideWidth: 760
	width: 940
	height: 460
	auto: false
	slideClass: 'slide'
	animationStart: ->
		$('.site_info').hide()
)
$('#page').fadeIn(1000, ->
	$('.slide:eq(1)').click()
)
$('.slide').each ->
	$('.site_info_btn, .close_btn', this).click =>
		$('.site_info', this).toggle('slide', { direction: 'left', easing: 'easeOutExpo' })
	
document.title = "Nick J. Reed | Portfolio"
window.initTooltip()