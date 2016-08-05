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
//= require jquery.remotipart
//= require bootstrap/dist/js/bootstrap
//= require moment/moment
//= require moment/locale/zh-cn
//= require eonasdan-bootstrap-datetimepicker/src/js/bootstrap-datetimepicker
//= require jquery-placeholder/jquery.placeholder
//= require video.js/dist/video-js/video.js
//= require multiselect/js/jquery.multi-select
//= require zeroclipboard/dist/ZeroClipboard.js
//= require typeahead.js/dist/typeahead.bundle.js

//= require tinymce
//= require cocoon
//= require select2
//= require select2_locale_zh-CN
//= require jquery.sortable
//= require bsmSelect/js/jquery.bsmselect
//= require bsmSelect/js/jquery.bsmselect.sortable
//= require bsmSelect/js/jquery.bsmselect.compatibility

//= require_directory .
//= require_self

$(function() {
  $('input, textarea').placeholder();

  $('select.select2:not(.datetime)').select2();

  $('.multi-select').multiSelect({
    keepOrder: true,
    selectableHeader: '待选择',
    selectionHeader: '已选择'
  });
  $('.select-all').click(function(e) {
    e.preventDefault();
    $($(e.target).data('target')).multiSelect('select_all');
  });
  $('.deselect-all').click(function(e) {
    e.preventDefault();
    $($(e.target).data('target')).multiSelect('deselect_all');
  });

  window.bsmSelect = $("select.bsmSelect").bsmSelect({
    multiple: 'multiple',
    removeLabel: '删除',
    title: '请选择',
    plugins: [
      $.bsmSelect.plugins.sortable({ axis: 'y' }),
      $.bsmSelect.plugins.compatibility()
    ],
  }).data('bsmSelect');

  $('select.bsmSelect').prop('multiple', true);

  $('.bsm-select-all').click(function(e) {
    e.preventDefault();
    $($(e.target).data('target')).children().attr('selected', 'selected').end().change();
  });

  $('.bsm-deselect-all').click(function(e) {
    e.preventDefault();
    $($(e.target).data('target')).children().attr('selected', false).end().change();
  });
});
