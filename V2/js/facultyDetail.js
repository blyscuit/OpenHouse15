$(document).ready(function() {
	$('#content_wrapper').show();
	$('#content_wrapper > section').addClass('container').each(function(i, elem) {
		var $elem = $(elem);
		var sectionName = $elem.attr('section-name');
		
		// Add header to each section
		var sectionHeaderContent = [
			'<div class="section-header">',
			'<div class="container">' + sectionName + '</div>',
			'</div>'
		].join('');

		var $sectionHeader = $(sectionHeaderContent);
		$elem.before($sectionHeader);

		// Add section into content list
		var contentListItemContent = [
			'<a href="#">' + sectionName + '</a>'
		].join('');
		
		var $contentListItem = $(contentListItemContent);
		$contentListItem.click(function(e) {
			$('html, body').animate({
				scrollTop: Math.max(0, $sectionHeader.offset().top - 20)
			}, 200);
			return false;
		});
		$('#content_list').append($contentListItem);

	});

	var oldScrollPos = 0;
	var scrollUpSum = 0;
	var isShowingTopBar = false;

	function checkGoToTopBar() {
		var currentScroll = $(this).scrollTop();

		scrollUpSum += oldScrollPos - currentScroll;
		if (scrollUpSum > 100) {
			scrollUpSum = 100;
			
			isShowingTopBar = true;
		} else if (scrollUpSum < 0) {
			scrollUpSum = 0;
			isShowingTopBar = false;
		}
		oldScrollPos = currentScroll;

		if (currentScroll < 100) isShowingTopBar = false;

		if (isShowingTopBar) {
			$('#go_to_top_bar').slideDown(200);
		} else {
			$('#go_to_top_bar').slideUp(200);
		}
	}

	$(window).scroll(checkGoToTopBar).resize(checkGoToTopBar);
	$('#go_to_top_bar').click(function(e) {
		$('html, body').animate({
			scrollTop: 0
		}, 300);
		return false;
	});
});
