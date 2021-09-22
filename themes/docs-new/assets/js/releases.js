// Fetch the given URL parameters
$.urlParam = function(name){
  var results = new RegExp('[\?&]' + name + '=([^]*)').exec(window.location.href);
  if (results==null){
      return null;
  }
  else{
      return results[1] || 0;
  }
}

// Find the index for the object
function findWithAttr(array, attr, value, product) {
  if (product === 'automate'){
    for(var i = 0; i < array.length; i += 1) {
      if(array[i][attr] === value) {
          return i;
      }
    }
    return -1;
  } else {
      for(var i = 0; i < array.length; i += 1){
        if (array[i] === value) {
          return i;
      }
    }
  }
}

// Load the Release Notes into the page
function loadReleaseNotesContents(releases, version, product) {

  if ( version == null ) {
    var index = releases.length - 1;
  } else {
    var index = findWithAttr(releases, "version", version, product);
  }

  var pageTOCButton = "<button type=\"button\" class=\"TOC-button hide-for-large\" data-toggle=\"offCanvasRightTOC\" data-close=\"left-nav-off-canvas\"><i class=\"fas fa-bars\"></i> Table of Contents</button>"

  var converter = new showdown.Converter({literalMidWordUnderscores: true});

  if (product === 'automate'){
    $.get(releases[index]["_links"]["release_notes"], function(rawReleaseNotes) {
      var html = converter.makeHtml(rawReleaseNotes);
      var friendlyDate = new Date(releases[index]["release_date"]);
      var options = { year: 'numeric', month: 'long', day: 'numeric' };

      $(".prose").html(html);
      $(".prose").prepend("<p><i>Released on " + friendlyDate.toLocaleString('en-US', options) + "</i></p>");
      $(".prose").prepend(pageTOCButton)


      $(".prose").prepend('<p class="release-notes-version">Version: ' + releases[index]["version"] + "</p>");
    });
  }
  else {

    releaseNoteURL = 'https://packages.chef.io/release-notes/' + product + '/' + releases[index] + '.md'

    $.get(releaseNoteURL, function(rawReleaseNotes) {
      var html = converter.makeHtml(rawReleaseNotes);

      $(".prose").html(html);
      $(".prose").prepend(pageTOCButton)
      $(".prose").prepend('<p class="release-notes-version">Version: ' + releases[index] + "</p>");
    }).fail( function() {
      $(".prose").html("<p>This release does not have any release notes.</p>");
      $(".prose").prepend(pageTOCButton)
      $(".prose").prepend('<p class="release-notes-version">Version: ' + releases[index] + "</p>");
    });
  }
}

function loadTableOfContents(releases, version, product) {

  // Automate release version numbers come from a JSON file with a release
  // version, release date, and link to each release note page
  // https://packages.chef.io/releases/current/automate.json

  // For other products, the JSON file contains just a release version with no
  // dates or links: https://omnitruck.chef.io/stable/<PRODUCT>/versions/all
  // Links to release notes are in the form:
  // https://packages.chef.io/release-notes/<PRODUCT>/<VERSION>.md

  if (product === 'automate'){
    var releaseSection = "";
    var groupedReleases = {};

    for ( var i = 0; i < releases.length; i++) {
      var date = new Date(releases[i]["release_date"]);
      var formattedMonth = ("0" + (date.getMonth() + 1)).slice(-2);
      var navDate = date.getFullYear() + "-" + formattedMonth;

      groupedReleases[navDate] = ( typeof groupedReleases[navDate] != 'undefined' && groupedReleases[navDate] instanceof Array ) ?
      groupedReleases[navDate] : []
      groupedReleases[navDate].push(releases[i]);
    }

    $.each(groupedReleases, function(navDate, releases) {
      if ( releases.length > 0 ) {
        var releaseList = "";
        var classes = "menu vertical nested";
        var li = "<li>";

        $.each(releases, function(_, release) {
          if ( version == release["version"] ) {
            li = '<li class="active">';
            classes = "menu vertical nested is-active";
          } else {
            li = "<li>";
          }
          releaseList = li + "<a href=\"?v=" + release["version"] + "\">" + release["version"] + "</a></li>" + releaseList;
        });
        releaseSection = "<li>" + navDate + "<ul class=\""+ classes + "\">" + releaseList + "</ul></li>" + releaseSection;
      }
    });
    $(".TableOfContents").html("<strong class = \"release_notes_toc\"><h4>Release Versions</h4></strong><button class=\"close-button hide-for-large\" aria-label=\"Close menu\" type=\"button\" data-close><span aria-hidden=\"true\">&times;</span></button>" + releaseSection);

  } else {
    $(".TableOfContents").html("<strong class = \"release_notes_toc\"><h4>Release Versions</h4></strong><button class=\"close-button hide-for-large\" aria-label=\"Close menu\" type=\"button\" data-close><span aria-hidden=\"true\">&times;</span></button><ul class=\"release-notes-menu\"></ul>");

    var releaseList = "";

    $.each(releases, function(index, release){
      releaseList = "<li><a href=\"?v=" + release + "\">" + release + "</a></li>" + releaseList;
    });
    $(".release-notes-menu").html(releaseList);
  }
  $(".nav").foundation();
}

function loadReleaseNotesPage(product) {
  var version = $.urlParam('v');

  // Automate uses packages.chef.io for version number information with the "current" channel
  // All other products use omnitruck.chef.io with the "stable" channel
  // E.g. https://omnitruck.chef.io/stable/inspec/versions/all

  if (product === "automate"){
    var versionsURL = "https://packages.chef.io/releases/current/automate.json"
  } else {
    var versionsURL = "https://omnitruck.chef.io/stable/" + product + "/versions/all"
  }

  // Load content and TOC depending on product
  $.getJSON({
    type: "GET",
    headers: {"Accept": "application/json"},
    url: versionsURL
  }).done(function (releases) {
    loadTableOfContents(releases, version, product);
    loadReleaseNotesContents(releases, version, product);
  });
}