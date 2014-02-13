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
//= require typeahead
//= require twitter/bootstrap
//= require mustache
//= require jquery.mustache
//= require underscore.js
//= require websocket_rails/main
//= require angular
//= require jquery-ui.min
//= require jquery.tinysort
//= require websocket_rails/main
//= require_tree .

angular.module('mixtapes',[])

if(window.opener) {
    window.opener.location.reload(true);
    window.close()
  }

$(document).ready(function() {
  $('a#fb-auth').click(function(e) {
  var width = 600, height = 400;
  var left = (screen.width / 2) - (width / 2);
  var top = (screen.height / 2) - (2 * height / 3);
  var features = 'modal=yes,location=yes,menubar=no,toolbar=no,status=no,width=' + width + ',height=' + height + ',toolbar=no,titlebar=no,left=' + left + ',top=' + top;
  var loginWindow = window.open('/users/auth/facebook', '_blank', features);
  loginWindow.focus();
  e.preventDefault();
  return false;
  });
});


