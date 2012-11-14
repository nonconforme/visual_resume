# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
pstateAvailable = (history && history.pushState)
initialURL = location.href
pushed = false
popped = false
popAction = false
reset = false

jQuery -> 
	$('#sublogo').hide()
	$('#home_btn').hide().live 'click', returnToNormal
	$('.block, .small_block_left, .small_block_right').each ->
		$(this).contents().hide()
	
	if directToPage()
		window.initialLoad = 1
		$('.initial_hover').removeClass 'initial_hover'
		setTimeout ( ->
			pageBlock(currentPage()).one('click', takeover).click()
		), 200
	else
		window.initialLoad = 0
		$('#logo').one 'click', stepOne
		
	initPushState()
	
	$('#throbbler_container').ajaxComplete ->
		$(this).hide()

initPushState = ->
	if pstateAvailable
		$(window).bind "popstate", ->
			if location.href == initialURL and not pushed then return
			popAction = true
			if location.pathname is '/' then returnToNormal() else pageBlock(location.pathname).click()
		
	
directToPage = -> currentPage() isnt 'home' and $('.p0[data-page="' + currentPage() + '"]').size() is 1
	
currentPage = (page) -> if page? then $('#main').data('current-page', page) else $('#main').data('current-page') 

pageBlock = (page) -> $('[data-page="' + page + '"], [data-url="' + page + '"]')
	
stepOne = ->
  $('.initial_hover').removeClass 'initial_hover'
  $('#p1, #p2, #p8').switchClass 'p0', 'p1', 1000, ->
    $('.block_label', this).fadeIn() if $(this).attr('id') is 'p1'
  $('#p4, #p5, #p6').switchClass 'p0', 'p5', 1000, ->
    $('.block_label', this).fadeIn() if $(this).attr('id') is 'p5'
  setTimeout stepTwo, 1000

stepTwo = ->
  $('#p6').switchClass 'p5', 'p6', 2000, 'easeOutElastic', ->
    $('.block_label', this).fadeIn()
  setTimeout stepThree, 400

stepThree = ->
  $('#p8').switchClass 'p1', 'p8', 2000, 'easeOutElastic', ->
    $('.block_label', this).fadeIn()
  setTimeout stepFour, 400

stepFour = ->
  $('#p2').switchClass 'p1', 'p2', 2000, 'easeOutElastic', ->
    $('.block_label', this).fadeIn()
  setTimeout stepFive, 400

stepFive = ->
  $('#p4').switchClass 'p5', 'p4', 2000, 'easeOutElastic', ->
    $('.block_label', this).fadeIn()
  setTimeout stepSix, 1000

stepSix = ->
  $('.block, .small_block_left, .small_block_right').unbind('click')
  $('.block, .small_block_left, .small_block_right').one('click', takeover)
  setTimeout ( ->  
    toggleSublogo('show')
  ), 1000
  setInterval rotate, 60000
  $('#logo').unbind('click').bind 'click', rotate

toggleSublogo = (action) -> 
	$('#sublogo').show('slide', direction: 'up') if action is 'show'
	$('#sublogo').hide('slide', direction: 'up') if action is 'hide'
				
takeover = ->
	$('.block_label', this).fadeOut(500) if window.initialLoad is 0
	$('.block, .small_block_left, .small_block_right').not(this).each ->
		$(this).fadeOut(1000) 
	$(this).addClass("#{$(this).data('page')}_bg")
	setTimeout ( ->
		$('#throbbler_container').fadeIn()
	), 1000
	$(this).addClass('highest_box').addClass('takeover', 2000, 'easeOutBounce', ->
		$('#page').addClass($(this).data('page'))
		$('.page_header_title').one('click', returnToNormal)
		$('.block, .small_block_left, .small_block_right').toggleClass 'outline' if window.initialLoad is 0
		$.getScript($(this).data('url'))
		currentPage($(this).data('page'))
		history.pushState(null, document.title, $(this).data('url')) if pstateAvailable and window.initialLoad is 0 and not popAction
		$('#home_btn').toggle('fade', 1000)
		popAction = false
		pushed = true
	)
	
	moveLogo($(this).data('page'))
	$('#logo').unbind('click').bind 'click', returnToNormal
	

moveLogo = (page) ->
	switch page
		when 'home'
			options = {top: '-=255px', left: '320px', fontSize: '72px', opacity: 1 }
			speed = 1000
			easing = ''
		when 'about'
			options = {top: '+=255', left: '790px', fontSize: '54px'}
			speed = 2000
			easing = 'easeOutBack'
		when 'portfolio' 
			options = {top: '+=255px', fontSize: '54px', opacity: 0}
			speed = 2000
			easing = ''
		else 
			options = {top: '+=255px', fontSize: '54px'}
			speed = 2000
			easing = 'easeOutBack'
	$('#p0').animate options, speed, easing
		
returnToNormal = ->
	$('#page_content').empty().hide()
	$('#page, #home_btn').hide()
	$('#page').removeClass($('.takeover').data('page'))
	$('#p0').addClass 'initial_hover' if window.initialLoad is 1
	currentPage('home')
	history.pushState(null, document.title, '/') if pstateAvailable and not popAction
	document.title = "Nick J. Reed"
	popAction = false
	pushed = true
	$('.block, .small_block_left, .small_block_right').not(this).each ->
		$(this).fadeIn(1000) 
	$('.takeover').removeClass('takeover', 1000, ->
		$(this).removeClass('highest_box education_bg').unbind('click').one('click', takeover)
		$('.block_label', this).fadeIn() if window.initialLoad is 0
		stepOne() if window.initialLoad is 1
		window.initialLoad = 0
	)
	moveLogo('home')
	$('#logo').unbind('click').bind 'click', rotate

	
rotate = ->
	if $('.takeover').size() is 0
		for i in [1..8]
			p = "p#{i}"
			p1 = if i is 8 then "p#{i - 7}" else "p#{i + 1}"
			p2 = if i > 6 then "p#{i - 6}" else "p#{i + 2}"
			$(".#{p}")
				.switchClass(p, p1, 1000)
				.switchClass(p1, p2, 1000)
		
window.initTooltip = (id = "home_btn") ->
	$('#' + id).tooltip({placement: 'right'})
	