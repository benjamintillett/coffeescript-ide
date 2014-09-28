$(document).ready(function(){
	$('.new-file').on('submit', function(e){
		var fileName = $('.new-file input').val();

		var newFile = Mustache.render($('#new-file-template').html(), { filename: fileName });
		console.log(newFile)
		$.post('/files?file=' + fileName, { content: '' }, function(){
			console.log("hello")
			$('.files').append(newFile)
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
				console.log("sudafhskgfjsdgafkjh")
				$item.remove();
			}
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


		// }).success(function(){
		// 	console.log($item)
		// 	console.log($('h1'))
		// 	console.log($(this))
		// 	$('.removed-item').remove();
		// });	