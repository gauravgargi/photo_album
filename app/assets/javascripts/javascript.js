// JS function for adding new photo
// Method call - albums/new.html.erb, albums/edit.html.erb
function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).parent().before(content.replace(regexp, new_id));
}