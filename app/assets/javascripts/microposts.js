function update_count() {
  remaining = 140 - $('#micropost_content').val().length
  if (remaining >= 0) {
    $('#counter').text(remaining + " left")
  } else {
    $('#counter').text("Message too long!")
  }
}

$(document).ready(function($) {
  update_count();
  $('#micropost_content').change(update_count);
  $('#micropost_content').keyup(update_count);
});