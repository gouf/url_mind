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

$(function() {
  $('#pop').on('click', function() {
    popReadLaterURL().done(openLinkWithNewTab);
  });
});
