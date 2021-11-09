import mapboxgl from 'mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';
import MapboxGeocoder from '@mapbox/mapbox-gl-geocoder';

const initMapbox = () => {
  const mapElement = document.getElementById('map');
  const fitMapToMarkers = (map, markers) => {
    const bounds = new mapboxgl.LngLatBounds();
    markers.forEach(marker => bounds.extend([marker.lng, marker.lat]));
    map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
  };
  function hide() {
    let markers = document.getElementsByClassName("mapboxgl-marker");
    for (let i = 0; i < markers.length; i++) {
      markers[i].style.visibility = "hidden";
    }
  }

  function show() {
    let markers = document.getElementsByClassName("mapboxgl-marker");
    for (let i = 0; i < markers.length; i++) {
      markers[i].style.visibility = "visible";
    }
  }

  if (mapElement) { // only build a map if there's a div#map to inject into
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/streets-v10'
    });

    window.fitToCard = function (event, latitude, longitude, user_latitude, user_longitude, info_window_user) {
      event.preventDefault();
      if (event.isTrusted) {
        const marker_consultory = {lat: latitude, lng: longitude};
        const marker_user = { lat: user_latitude, lng: user_longitude};
        const markers_for_user_consultory = [marker_consultory,marker_user];
        const popup = new mapboxgl.Popup().setHTML(info_window_user.info_window);
        hide();
        new mapboxgl.Marker({
          color: "#6f42c1",
        })
          .setLngLat(marker_user)
          .setPopup(popup)
          .addTo(map);
        new mapboxgl.Marker({
          color: "#6f42c1",
        })
          .setLngLat(marker_consultory)
          .addTo(map);
        fitMapToMarkers(map, markers_for_user_consultory);
      }
      else {
        show();
        const marker_consultory = { lat: latitude, lng: longitude };
        const markers_for_user_consultory = [marker_consultory, marker_user];
        fitMapToMarkers(map, markers_for_user_consultory);
      };
    };


    map.addControl(new MapboxGeocoder({
      accessToken: mapboxgl.accessToken,
      mapboxgl: mapboxgl
    }));

    const markers = JSON.parse(mapElement.dataset.markers);
    markers.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window);
      new mapboxgl.Marker()
        .setLngLat([marker.lng, marker.lat])
        .setPopup(popup)
        .addTo(map);
    });
    fitMapToMarkers(map, markers);
  } else {
    void(0);
  }
};

export { initMapbox };
