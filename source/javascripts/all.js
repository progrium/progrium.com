//= require_tree .
//= require "jquery/dist/jquery.min.js"
//= require "bootstrap/dist/js/bootstrap.min.js"

$(document).ready(function() {
	window.addEventListener('scroll', function(e){
        var distanceY = window.pageYOffset || document.documentElement.scrollTop,
            shrinkOn = 60,
            header = document.querySelector("header");
        if (distanceY > shrinkOn) {
        	$("header").addClass("smaller");
            
        } else {
            if ($("header").hasClass("smaller")) {
                $("header").removeClass("smaller");
            }
        }
    });
});
