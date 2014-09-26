$(document).ready(function(){
	$('.new-file').on('submit', function(e){
		e.preventDefault();
		var fileName = $('.new-file input').val();
		$.post('/files?file=' + fileName,  { content: '' }, function(){
			$('.files').append('<li>' + fileName + '<a class="edit" href="/edit?file=' + fileName + '"><button class="edit">Edit</button></a><button class="delete">Delete</button></li>')
		}).always(function(){
			$('.new-file input').val('');
		});
	});

	$('.files').on('click', 'button.delete', function(e) {
	    e.preventDefault();
	    $item = $(this).parent();
	    fileName = $item.children('span').text()
		$.ajax('/files?file=' + fileName, {
			type: 'delete',
			success: function() {
				$item.addClass('removed-item');
			}
		}).success(function(){
			console.log($item)
			console.log($('h1'))
			console.log($(this))
			$('.removed-item').remove();
		});	
	})

	$('.save').on('click', function(e){
		e.preventDefault();
		var content = $('#editform textarea').val();
		var fileName = $('#editform textarea').data('filename')
		$.post('/files?file=' + fileName, { content: content }, function(){
			console.log('ethel is not hungover')
		});
	});
});