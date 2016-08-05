// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap/dist/js/bootstrap
//= require jquery.flexslider
//= require simple-inheritance.min
//= require klass.min
//= require code.photoswipe
//= require video.js/dist/video-js/video.js
//= require iCheck/icheck.js
//= require seiyria-bootstrap-slider/js/bootstrap-slider.js

//= require_directory .
//= require_self

$(function() {
  $('input').iCheck({
    checkboxClass: 'icheckbox_square-red',
    radioClass: 'iradio_square-red',
  });
});
