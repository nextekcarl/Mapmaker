$('div.content').on("click", '#generate-map', function () {
  doMap(d3.select('#map'), detailedParams);
});
