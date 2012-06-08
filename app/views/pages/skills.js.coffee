$("#page").html("<%= escape_javascript(render(:template => "pages/skills", :formats => :html)) %>").fadeIn(1000)
document.title = "Nick J. Reed | Skills"

showWordCloud = (id) ->
	$('#word_cloud').tagcanvas({
		stretchX: 3,
		weight: true,
		weightFrom: 'data-weight',
		initial: [0.04, -0.08],
		textColour: '#ffffff',
		shadow: '#0682C4',
		shadowOffset: [0, 2],
		shadowBlur: 15,
		frontSelect: true,
		outlineOffset: 1,
		outlineMethod: 'colour',
		minSpeed: .003,
		reverse: true,
		textFont: '' }, id)
	
window.loadTagCanvas()

$('a', '#skills_categories').click ->
	$('#word_cloud').fadeOut(500, =>
		$('#active_skill_category').text($(this).text())
		$('#back_to_categories').fadeIn()
		showWordCloud $(this).data('target')
		$('#word_cloud').fadeIn(1000)
	)
	false

$('a', '.category').click (e) -> e.preventDefault() if $(this).attr('href') is '#'
	
showWordCloud 'skills_categories'

$('#back_to_categories').hide().click ->
	$('#active_skill_category').text('')
	$(this).hide()
	showWordCloud 'skills_categories'
	
window.initTooltip()