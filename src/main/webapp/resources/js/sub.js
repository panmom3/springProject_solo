(function($) {
    'use strict';

    var $window = $(window),
        $document = $(document),
        $html = $('html'),
        $head = $('head'),
				$screen = $.screen,
        $inArray = $.inArray;

    $window.on('load', function() {

		    //레이어팝업
				$('.popup_btn').click(function (){
					$(this).siblings().addClass('on');
				});
				$('.popup_close').click(function (){
					$('.popup').removeClass('on');
					$('.popup_btn').focus();
				});
				
		    //FAQ
				$('.temp_accordion .accordion_item button.accordion_btn').on('click', function() {
					var $this = $(this),
						$MyParent = $this.parent('.accordion_item'),
						IsActive = $MyParent.is('.active'),
						$MyLayer = $this.siblings('.accordion_con');
					if(!IsActive){
						$MyParent.addClass('active');
						$MyLayer.slideDown();
						$this.attr('title', '내용닫기');
					} else{
						$MyParent.removeClass('active');
						$MyLayer.slideUp();
						$this.attr('title', '내용열기');
					}
				});
		

        $window.on('screen:tablet screen:phone', function(event) {
            
        });
    });
	$window.on('load', function(event) {
		$window.on('screen:wide screen:web', function(event) {

		});
	});
})(jQuery);