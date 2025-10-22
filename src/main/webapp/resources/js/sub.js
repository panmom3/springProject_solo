

(function($) {
    'use strict';

    var $window = $(window),
        $document = $(document),
        $html = $('html'),
        $head = $('head'),
		$screen = $.screen,
        $inArray = $.inArray;

    $window.on('load', function() {

		//여기서부터 코드 작성해주세요


		

        $window.on('screen:tablet screen:phone', function(event) {
            
        });
    });
	$window.on('load', function(event) {
		$window.on('screen:wide screen:web', function(event) {

		});
	});
})(jQuery);