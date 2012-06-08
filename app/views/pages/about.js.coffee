$("#page").html("<%= escape_javascript(render(:template => "pages/about", :formats => :html)) %>")
$('#pg2, #prev_page', '#page').hide()
$('#page').fadeIn(1000)

turnPage = ->
	$('.pg, #next_page, #prev_page').toggle()
	
$('#next_page, #prev_page').click turnPage
$('#next_page').tooltip({placement: 'left'})
$('#prev_page').tooltip({placement: 'right'})

document.title = "Nick J. Reed | About"
window.initTooltip()

