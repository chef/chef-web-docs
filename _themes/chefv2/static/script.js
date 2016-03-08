var hasHref = function (linkURL) {
  return linkURL == undefined ? true : false;
}

var isAbsoluteLink = function (linkURL) {
  return (linkURL.indexOf("/") != 0) && (linkURL.indexOf("http") >= 0);
}

var isDifferentHostname = function (linkURL) {
  return linkURL.indexOf(location.hostname) < 0;
}

var isFragmentLink = function(linkURL) {
  return linkURL.indexOf("#") != 0;
}

var isOutboundLink = function(linkURL) {
  return isAbsoluteLink(linkURL) && isDifferentHostname(linkURL) && isFragmentLink(linkURL);
}

var addOutboundLinkTracking = function() {
  $("a").each(function() {
    var $link = $(this);
    var linkURL = $link.attr("href");

    if (hasHref(linkURL)) {
      return true;
    }

    if (isOutboundLink(linkURL)) {
      $link.attr("onclick", "trackOutboundLink('" + linkURL + "'); return false;");
    }
  });
};

var pageSetup = function() {
  addOutboundLinkTracking();

  // Nav Interactions
  const $navLinks = $(".nav-links.links-main");
  const $navDocs = $(".nav-docs");
  const $navElements = [$navDocs, $navLinks];
  const navBreakpoint = 730; // navBreakpoint should be the same as breakpoint in _nav.scss file
  const navHeight = $(".nav-main").outerHeight();
  var navDocsHeight, navDocsItems, navLinksHeight, windowWidth;
  var largeScreen;

  var removeOpenClass = function(elements) {
    $.each(elements, function(index, value) {
      this.removeClass("is-open");
    });
  }

  var checkWindowSize = function() {
    windowWidth = $(window).width();

    navDocsItemsHeight = $(".nav-docs-items").outerHeight();
    $(".document").css("min-height", navDocsItemsHeight);

    if (windowWidth > navBreakpoint) {
      largeScreen = true;
      $navLinks.css("top", "");
      removeOpenClass($navElements);
    } else {
      largeScreen = false;
      navDocsHeight = $('.nav-docs').outerHeight();
      navLinksHeight = $navLinks.outerHeight();
      $navLinks.css("top", navHeight + navDocsHeight + "px");
    }
  }

  checkWindowSize();
  window.setTimeout(checkWindowSize, 1000);

  $(window).resize(function () {
    checkWindowSize();
  });

  $("#nav-icon").click(function () {
    if (!largeScreen) {
      if ($navLinks.hasClass("is-open")) {
        removeOpenClass($navElements);
      } else {
        $navLinks.addClass("is-open");
        $navDocs.addClass("is-open");
      }
    }
  });

  // Docs Nav 
  $(".has-sub-items-content").click(function() {
    $(this).parent(".has-sub-items").toggleClass("is-open");

    navDocsItemsHeight = $(".nav-docs-items").outerHeight();
    $(".document").css("min-height", navDocsItemsHeight);

    navDocsHeight = $('.nav-docs').outerHeight();
    navLinksHeight = $navLinks.outerHeight();
    $navLinks.css("top", navHeight + navDocsHeight + "px");
  });

  $(".sub-items a").click(function(){
    $(".sub-items .is-active").removeClass("is-active");

    $(this).addClass("is-active");
  });

  // Version Picker Dropdown 
  $(".dropdown-select").click(function () {
    $(this).parent(".dropdown-wrapper").toggleClass("is-open");
  });

  $("html").click(function(event) {
    if ($(".dropdown-wrapper").hasClass("is-open") && !($(event.target).parents(".dropdown-wrapper").length)) {  
      $(".dropdown-wrapper").removeClass("is-open");
    }
    })
  
  $(".dropdown-wrapper .has-sub-items").click(function() {
    if (!largeScreen) {
      $(this).toggleClass("is-open");
      $(this).find(".dropdown-sub-items").toggleClass("is-open");
    }
  });

  // Add Active State to Docs Nav for Sub-pages
  var currentUrl = location.pathname + location.hash;
  var $docsNavLinks = $(".nav-docs-link");
  var linkUrl;

  $docsNavLinks.each(function() {
    var $this = $(this);
    linkUrl = $this.attr("href");

    if (currentUrl == linkUrl) {
      $(".nav-docs-link.is-active").removeClass("is-active");
      $(".has-sub-items.is-open").removeClass("is-open");
      $this.addClass("is-active");
      $this.parents(".has-sub-items").addClass("is-open");

      navDocsItemsHeight = $(".nav-docs-items").outerHeight();
      $(".document").css("min-height", navDocsItemsHeight);
    }
  });

  // Auto focus Search Bar on Large Screens
  if (largeScreen) {
    $("#docs-search").focus();
  }
};

$(document).ready(pageSetup);
