$(document).ready(function(){
	$('.new-file').on('submit', function(e){
		e.preventDefault();
		var fileName = $('.new-file input').val();
		$.post('/files?file=' + fileName, { content: "" }, function(){
			$('.files').append('<li>' + fileName + '</li>');
		}).always(function(){
			$('.new-file input').val('');
		});
	});
})