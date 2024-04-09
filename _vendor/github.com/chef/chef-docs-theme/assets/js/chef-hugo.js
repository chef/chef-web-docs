// Initialize Foundation
// https://get.foundation/sites/docs/installation.html
// Also add links to heading IDs

(function (win, doc,$) {

  $(document).foundation();

  $(".prose > :header" ).add(".chef-product-version > :header" ) .each(function () {
    $(this).append("<a href=\"\#" + $(this).attr("id") + "\"><svg class=\"svg-link\"width=\"19px\" height=\"19px\" viewBox=\"2 2 20 20\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\"><path fill-rule=\"evenodd\" clip-rule=\"evenodd\" d=\"M10.975 14.51a1.05 1.05 0 0 0 0-1.485 2.95 2.95 0 0 1 0-4.172l3.536-3.535a2.95 2.95 0 1 1 4.172 4.172l-1.093 1.092a1.05 1.05 0 0 0 1.485 1.485l1.093-1.092a5.05 5.05 0 0 0-7.142-7.142L9.49 7.368a5.05 5.05 0 0 0 0 7.142c.41.41 1.075.41 1.485 0zm2.05-5.02a1.05 1.05 0 0 0 0 1.485 2.95 2.95 0 0 1 0 4.172l-3.5 3.5a2.95 2.95 0 1 1-4.171-4.172l1.025-1.025a1.05 1.05 0 0 0-1.485-1.485L3.87 12.99a5.05 5.05 0 0 0 7.142 7.142l3.5-3.5a5.05 5.05 0 0 0 0-7.142 1.05 1.05 0 0 0-1.485 0z\" fill=\"#BABDBE\"/></svg></i></a>");
  });

}(window, document, jQuery));
