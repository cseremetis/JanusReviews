$(document).on "turbolinks:load", ->

	$('#face1').click (e) ->
		e.preventDefault()
		$('img').css 'opacity', '1'
		$('#radio1').prop 'checked', 'true'
		$('#face1').css 'opacity', '0.5'

	$('#face2').click (e) ->
		e.preventDefault()
		$('img').css 'opacity', '1'
		$('#radio2').prop 'checked', 'true'
		$('#face2').css 'opacity', '0.5'

	$('#face3').click (e) ->
		e.preventDefault()
		$('img').css 'opacity', '1'
		$('#radio3').prop 'checked', 'true'
		$('#face3').css 'opacity', '0.5'

	$('#face4').click (e) ->
		e.preventDefault()
		$('img').css 'opacity', '1'
		$('#radio4').prop 'checked', 'true'
		$('#face4').css 'opacity', '0.5'

	$('#face5').click (e) ->
		e.preventDefault()
		$('img').css 'opacity', '1'
		$('#radio5').prop 'checked', 'true'
		$('#face5').css 'opacity', '0.5'

	$('#face6').click (e) ->
		e.preventDefault()
		$('img').css 'opacity', '1'
		$('#radio6').prop 'checked', 'true'
		$('#face6').css 'opacity', '0.5'