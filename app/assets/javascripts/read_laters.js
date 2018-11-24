// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function openLinkWithNewTab(object) {
  window.open(object.url, '_blank');
}

function popReadLaterURL() {
  return (
    $.get('/read_laters/pop')
  );
}

function setRemoveTargetUrlValue(url) {
  $('#delete_target_url').val(url)
}

function submitRemoveUrlValue(url) {
  setRemoveTargetUrlValue(url)
  $('#delete_url').trigger('submit')
}

$(function() {
  $('#pop').on('click', function() {
    popReadLaterURL().done(openLinkWithNewTab);
  });
  $('.js-url-popup li').on('click', function() {
    var url = $(this).data('url')

    window.open(url, '_blank');
    submitRemoveUrlValue(url)
  })
});
