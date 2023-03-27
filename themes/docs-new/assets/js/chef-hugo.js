// Initialize Foundation
// https://get.foundation/sites/docs/installation.html
// Also add links to heading IDs

(function (win, doc,$) {

  $(document).foundation();

  $(".prose > :header" ).add(".chef-product-version > :header" ) .each(function () {
    $(this).append("<a href=\"\#" + $(this).attr("id") + "\"><i class=\"fas fa-link\"></i></a>");
  });

}(window, document, jQuery));
