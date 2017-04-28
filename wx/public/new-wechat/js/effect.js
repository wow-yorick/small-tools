$(document).ready(function(e) {
	
	var phone_h = $('.phone-hover a'),
	    form = $('.content form');
	    
	phone_h.click(function(){
		var i = $(this).index();
		phone_h.removeClass('cur');
	    $(this).addClass('cur');
		form.hide();
		form.eq(i).show();		
	});
	
	
	(function showtime(){
	    var now_time = new Date();
		var hours = now_time.getHours();
		var minutes= now_time.getMinutes();
		var timer = now_time.toDateString();
		timer +=" " + ((hours>24)?hours-24:hours);
		timer +=((minutes<10)?":0":":") + minutes;
		$('.show-time').text(timer);
		window.setTimeout(showtime,1000);
	})();
	
	
	$('.datepicker').datepicker();
	slider();
});


function slider(){
var simpleslider	= $('.simple-slider');
var item = $('.simple-slider .slider-item');
var num = 0;
var len = item.length;
var set = window.setInterval(auto, 2000);
    function auto(){
					if(num < len){
					item.hide();
					item.eq(num).show();
						num ++;		
					} else {
						num = 0;
					}
			}
	
}