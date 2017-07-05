  var map;
  alert("hello from index.js");

  function initMap() {
    map = new google.maps.Map(document.getElementById('map'), {
      center: {lat: 39.5, lng: -98.35},
      zoom: 4
    });
  }

// alert(gon.location)
// alert(gon.miles)
// alert(gon.result)
