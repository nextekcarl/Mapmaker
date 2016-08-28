$(function ($){
    $(document).ajaxStop(function(){
        $("#loading-indicator").hide();
     });
     $(document).ajaxStart(function(){
         $("#loading-indicator").show();
     });
});

function generateMap() {
  var detailedParams = {
      extent: defaultExtent,
      generator: generateCoast,
      npts: Math.floor((Math.random() * 10) + 20) * 1000,
      ncities: Math.floor((Math.random() * 8) + 5),
      nterrs: Math.floor((Math.random() * 10) + 1),
      mountains: Math.floor((Math.random() * 70) + 30),
      fontsizes: {
          region: 30,
          city: 20,
          town: 15
      }
  }
  doMap(d3.select('#map'), detailedParams);
}
$(document).on('turbolinks:load', function() {
  $('body').on("click", '#generate-map', function () {
    setTimeout(generateMap(), 0);
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
    $('#loading-indicator').show();
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

  $('body').on("click", '.x-highlight-city', function () {
    var $city = $(this).data('city');
    $('svg').children("text.city:contains('"+$city+"')")
            .toggle('highlight')
            .fadeIn()
            .toggle('highlight')
            .fadeIn();
  });
});
