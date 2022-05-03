// import { Controller } from "@hotwired/stimulus"
// import mapboxgl from "mapbox-gl"

// export default class extends Controller {
//   static values = {
//     apiKey: String,
//     markers: Array
//   }

//   connect() {
//     mapboxgl.accessToken = this.apiKeyValue

//     this.map = new mapboxgl.Map({
//       container: this.element,
//       style: "mapbox://styles/mapbox/streets-v10"
//     })
//     this.#addMarkersToMap()
//     this.#fitMapToMarkers()
//   }

//   #addMarkersToMap() {
//     this.markersValue.forEach((marker) => {
//       new mapboxgl.Marker()
//         .setLngLat([ marker.lng, marker.lat ])
//         .addTo(this.map)
//     });
//   }

//   #fitMapToMarkers() {
//     const bounds = new mapboxgl.LngLatBounds()
//     this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
//     this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 3000 })
//   }
// }

// ----------------------------------------------------------------
// # Place this in the views/ page that you would like that map on
// <%# Mapbox map %>
// <div style="width: 100%; height: 600px;"
//   data-controller="mapbox"
//   data-mapbox-markers-value="<%= @markers.to_json %>"
//   data-mapbox-api-key-value="<%= ENV['MAPBOX_API_KEY'] %>">
// </div>
// ----------------------------------------------------------------
