/**
 * Main JS file for Horace behaviours
 */
(function ($) {
	"use strict";

	var $body = $('body');

	$(document).ready(function(){

		// Responsive video embeds
		$('.post-content').fitVids();

		// Scroll to top
		$('#top-button').on('click', function(e) {
			$('html, body').animate({
				'scrollTop': 0
			});
			e.preventDefault();
		});

		// Hidden panels
		$('#sidebar-show, #sidebar-hide').on('click', function(e){
			$body.toggleClass('sidebar--opened');
			$(this).blur();
			e.preventDefault();
		});
		$('#member-menu-show, #member-menu-hide').on('click', function(e){
			$body.toggleClass('member--menu--opened');
			e.preventDefault();
		});
		$('#site-overlay').on('click', function(e){
			$body.removeClass('sidebar--opened member--menu--opened');
			e.preventDefault();
		});

		// Show comments
		var interval = setInterval(function() {
			var disqusHeight = $('#disqus_thread').height();
			if ( disqusHeight > 100 ) {
				$('#comments-area').addClass('comments--loaded');
				clearInterval(interval);
			}
		}, 100);
		$('#comments-overlay, #comments-show').on('click', function(e){
			$('#comments-area').removeClass('comments--loaded').addClass('comments--opened');
			e.preventDefault();
		});

		// Gallery adjustments
		$( '.kg-gallery-image > img' ).each( function() {
			var _this = $(this),
				$container = _this.closest('.kg-gallery-image'),
				width = _this.attr('width'),
				height = _this.attr('height'),
				ratio = width / height;
			$container.css({'flex' : ratio + ' 1 0%' });
		});
		$('.kg-gallery-card').each( function() {
			var _this = $(this);
			_this.find('img').simpleLightbox({
				sourceAttr: 'src',
				captions: false,
				closeText: '<span aria-hidden="true" class="icon icon-close"></span>',
				navText: ['<span class="icon icon-arrow-left" aria-hidden="true"></span>','<span class="icon icon-arrow-right" aria-hidden="true"></span>']
			});
		});
	});

}(jQuery));
