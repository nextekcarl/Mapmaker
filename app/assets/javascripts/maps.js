$(document).on('turbolinks:load', function() {
  $('body').on("click", '#generate-map', function () {
    doMap(d3.select('#map'), detailedParams);
    $('body text.region').show();
    $('body .city').show();
    $('body path.border').show();
    $('body path.river').show();
  });

  $('body').on("click", '#toggle-regions', function () {
    $('body text.region').toggle();
    $('body path.border').toggle();
  });

  $('body').on("click", '#toggle-cities', function () {
    $('body .city').toggle();
  });

  $('body').on("click", '#toggle-rivers', function () {
    $('body path.river').toggle();
  });

  $('body').on("click", '#save-map', function () {
    //Package up the name, description, and svg data,
    //ajax off to rails action, and respond to user.
    var $form = $('#map-form').children('form');
    var $serializer = new XMLSerializer();
    var $svgSerialized = $serializer.serializeToString(document.getElementById('map'));
    $.ajax({
      type: "POST",
      url: "/maps",
      data: $form.serialize() + '&map%5Bsvg%5D=' + $svgSerialized
    }).success({

    }).fail({

    });
  });
});
