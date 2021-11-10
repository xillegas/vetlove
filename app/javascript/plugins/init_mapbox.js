import mapboxgl from 'mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';
import MapboxGeocoder from '@mapbox/mapbox-gl-geocoder';

const initMapbox = () => {
  const mapElement = document.getElementById('map');
  const draggableMapElement = document.getElementById('draggableMap');

  // console.log(mapElement);
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

  function centerElement(geometry, mapSelected) {
    mapSelected.flyTo({
      center: geometry,
      speed: 0.5,
      essential: true,
      zoom: 13
    });
  }

  if (mapElement) { // only build a map if there's a div#map to inject into
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/streets-v11',
      center: [-66.8762112, 10.4923136],
      zoom: 13
    });

    window.searchVet = function (event, latitude, longitude) {
      event.preventDefault();
      if (event.isTrusted) {
        const markerVet = { lat: latitude, lng: longitude };
        // console.log(markerVet)
        hide();
        new mapboxgl.Marker({
          color: "#6f42c1",
        })
          .setLngLat(markerVet)
          .addTo(map);
        centerElement(markerVet, map)
      }
      else {
        // console.log('estoy en else')
        void (0);
      };
    };

    window.fitToCard = function (event, latitude, longitude, infoWindowUser) {
      event.preventDefault();
      if (event.isTrusted) {
        // console.log(infoWindowUser.user_ip)
        // console.log(infoWindowUser.lat)
        // console.log(infoWindowUser.lng)
        // console.log(infoWindowUser.info_window)
        const markerConsultory = { lat: latitude, lng: longitude };
        const markerUser = { lat: infoWindowUser.lat, lng: infoWindowUser.lng };
        const popup = new mapboxgl.Popup().setHTML(infoWindowUser.info_window);
        hide();
        new mapboxgl.Marker({
          color: "#ac3235",
        })
          .setLngLat(markerUser)
          .setPopup(popup)
          .addTo(map);

        const markerConsult = JSON.parse(mapElement.dataset.markers);
        if (markerConsult) {
          markerConsult.forEach((marker) => {
            const popupConsultory = new mapboxgl.Popup().setHTML(marker.info_window);
            new mapboxgl.Marker({
              color: "#6f42c1"
            })
              .setLngLat(markerConsultory)
              .setPopup(popupConsultory)
              .addTo(map);
          })
        }
        // new mapboxgl.Marker({
        //   color: "#6f42c1",
        // })
        //   .setLngLat(markerConsultory)
        //   .addTo(map);
        // console.log(markerForUserConsultory);
        // fitMapToMarkers(map, markerForUserConsultory);
        // console.log(markerConsultory);
        centerElement(markerConsultory, map)
      }
      else {
        void(0);
      };
    };


    map.addControl(new MapboxGeocoder({
      accessToken: mapboxgl.accessToken,
      mapboxgl: mapboxgl
    }));
    // Agrega el FullScreen
    map.addControl(new mapboxgl.FullscreenControl());

    const markers = JSON.parse(mapElement.dataset.markers);
    if (markers) {
      markers.forEach((marker) => {
        const popup = new mapboxgl.Popup().setHTML(marker.info_window);
        new mapboxgl.Marker()
          .setLngLat([marker.lng, marker.lat])
          .setPopup(popup)
          .addTo(map);
      });
      fitMapToMarkers(map, markers);
      map.on('load', (event) => {
        map.resize();
      });
    } else {
      void (0);
    }
    // map.on('click', addMarker);
  } else {
    void (0);
  }


  if (draggableMapElement) {
    mapboxgl.accessToken = draggableMapElement.dataset.mapboxApiKey;
    // const coordinates = document.getElementById('coordinates');
    const longitude = document.getElementById('longitud_vet');
    const latitude = document.getElementById('latitud_vet');

    const map = new mapboxgl.Map({
      container: 'draggableMap',
      style: 'mapbox://styles/mapbox/streets-v11',
      center: [-66.8762112, 10.4923136],
      zoom: 8
    });

    map.addControl(new mapboxgl.FullscreenControl());

    const marker = new mapboxgl.Marker({
      draggable: true
    })
      .setLngLat([-66.8762112, 10.4923136])
      .addTo(map);

    function onDragEnd() {
      const lngLat = marker.getLngLat();
      longitude.value = lngLat.lng
      latitude.value = lngLat.lat
      // coordinates.style.display = 'block';
      // coordinates.innerHTML = `Longitude: ${lngLat.lng}<br />Latitude: ${lngLat.lat}`;
    }

    marker.on('dragend', onDragEnd);
  } else {
    void (0);
  }
};

export { initMapbox };
