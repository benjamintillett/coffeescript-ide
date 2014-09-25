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

	$(".files").on('click', 'button.delete', function(e) {
	    e.preventDefault();
	    $item = $(this).parent();
	    fileName = $item.children('span').text()
		$.ajax('/files?file=' + fileName, {
			type: 'delete',
			success: function() {
				// $item.addClass('removed-item');
			}
		}).success(function(){
			console.log($item)
			$($item).remove();
		});	
	})

})