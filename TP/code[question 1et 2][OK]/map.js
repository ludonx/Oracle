let xhr = new XMLHttpRequest();
var basicUrl1 = 'https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&callback=myfeedMap&starttime=2014-01-01&endtime=2014-01-02';
var url ='query.json';
var AllMyData;
var myJsonData;
var basicUrl = 'https://earthquake.usgs.gov/fdsnws/event/1/';
var myQuery ='query?format=geojson&callback=myfeedMap&starttime=2019-01-01T12:00:00&endtime=2019-01-02T12:00:00&minmagnitude=1&maxmagnitude=3';
var myUrlQuery=basicUrl+myQuery;
var dateDebut = '2019-01-01T12:00:00';//'2019-01-01';//
var dateFin =   '2019-01-02T12:00:00';//'2019-01-02';//
var minMag=1;
var maxMag=5;

function CreateQuery(dateDebut,dateFin,minMag,maxMag){
	var q='https://earthquake.usgs.gov/fdsnws/event/1/';
	var myCallBackFunction='myfeedMap'; // nom de la function qui permettra de récupére les données
	q+='query?format=geojson&callback='+myCallBackFunction+'&starttime='+dateDebut+'&endtime='+dateFin+'&minmagnitude='+minMag+'&maxmagnitude='+maxMag+' ';
	return q;
	//myUrlQuery
}
function showInfoSimulation(dateDebut,dateFin,minMag,maxMag){


	var msgDeb="<div>La carte ci-dessous presente les tremblements de terre qui verifier les critères suivants :</div>"
	var output = "<ul>"; // Open list
	var i;
		output += "<li> Date Début : " + dateDebut + "</li>";
		output += "<li> Date Fin : " + dateFin + "</li>";
		output += "<li> Magnitude [Min - Max] : [" + minMag +" - " +maxMag+ "]</li>";

	output += "</ul> "; // Close list

	var htmlOutput =msgDeb+output;

	// Output the data to the "artistlist" element
	document.getElementById("info_simul").innerHTML = htmlOutput;

}













// On initialise la latitude et la longitude de Paris (centre de la carte)

function $_GET(param) {
	var vars = {};
	window.location.href.replace( location.hash, '' ).replace(
		/[?&]+([^=&]+)=?([^&]*)?/gi, // regexp
		function( m, key, value ) { // callback
			vars[key] = value !== undefined ? value : '';
		}
	);

	if ( param ) {
		return vars[param] ? vars[param] : null;
	}
	return vars;
}

var champs_get = $_GET();
var lat = champs_get['latitude']==null?48.8566101:champs_get['latitude'];
var lon = champs_get['longitude']==null?2.3514992:champs_get['longitude'];

var macarte = null;

var markerClusters; // Servira à stocker les groupes de marqueurs
// Nous initialisons une liste de marqueurs
// Fonction d'initialisation de la carte
function initMap() {

	// Créer l'objet "macarte" et l'insèrer dans l'élément HTML qui a l'ID "map"
  macarte = L.map('map', {
		minZoom: 0,
		maxZoom: 20
	});

	var myIcon = L.icon({
		iconUrl: "icons/MyIcon.png",
		iconSize: [50, 50],
		iconAnchor: [20, 40],
		popupAnchor: [-3, -76],
	});
	// Leaflet ne récupère pas les cartes (tiles) sur un serveur par défaut. Nous devons lui préciser où nous souhaitons les récupérer. Ici, openstreetmap.fr
  L.tileLayer('https://{s}.tile.openstreetmap.fr/osmfr/{z}/{x}/{y}.png', {
    // Il est toujours bien de laisser le lien vers la source des données
    attribution: 'données © <a href="//osm.org/copyright">OpenStreetMap</a>/ODbL - rendu <a href="//openstreetmap.fr">OSM France</a>'
  }).addTo(macarte);



	//on se place a l'endroit souhaite
	macarte.setView([lat, lon], 1);
	// mon marqueur position


/*
	// on récupére l'ensemble des tremblement de terre
	// Create a <script> tag and set the USGS URL as the source.
  var script = document.createElement('script');
  // This example uses a local copy of the GeoJSON stored at
  // http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/2.5_week.geojsonp
	//https://earthquake.usgs.gov/fdsnws/event/1/count?starttime=2014-01-01&endtime=2014-01-02
  script.src = 'https://developers.google.com/maps/documentation/javascript/examples/json/earthquake_GeoJSONP.js';
  document.getElementsByTagName('head')[0].appendChild(script);*/
	var script = document.createElement('script');
        script.setAttribute(
            'src',
            CreateQuery(dateDebut,dateFin,minMag,maxMag));
        document.getElementsByTagName('head')[0].appendChild(script);

};
/*******************************************************************************************/

// on affiche tous les tremblements de terre
// Defines the callback function referenced in the jsonp file.


function myfeedMap(data) {

	// Nous initialisons la liste des marqueurs
	var markers = [];
	// Nous initialisons les groupes de marqueurs
	markerClusters = L.markerClusterGroup();

		//AllMyData=results.features;
		AllMyData=data.features;

		//L.geoJSON(myJsonData).addTo(macarte);

    for (var i = 0; i < AllMyData.length; i++) {
      var coords = AllMyData[i].geometry.coordinates;
			var mylat=coords[1];
			var mylon=coords[0];
			var place = AllMyData[i].properties.place;
			var mag = AllMyData[i].properties.mag;
			var time = AllMyData[i].properties.time;
			var date = new Date(time);

			//macarte.flyTo([mylat,mylon]);


			var marker = L.marker([mylat,mylon]);
			marker.bindPopup(place);
			markerClusters.addLayer(marker); // Nous ajoutons le marqueur aux groupes
			markers.push(marker); // Nous ajoutons le marqueur à la liste des marqueurs du groupes
			// on ajouter la magnetude

			//setTimeout(addCircle(mylat,mylon,mag,date), 10000); ne marche pas car cette partie est execute avant l'affichage sur la map
			addCircle(mylat,mylon,mag,date);


    }

		var group = new L.featureGroup(markers); // Nous créons le groupe des marqueurs pour adapter le zoom
		macarte.fitBounds(group.getBounds().pad(0.5)); // Nous demandons à ce que tous les marqueurs soient visibles, et ajoutons un padding (pad(0.5)) pour que les marqueurs ne soient pas coupés
		macarte.addLayer(markerClusters);// Nous ajoutons le marqueur aux groupes

};
function addCircle(mylat,mylon,mag,date){
	var mycircle= L.circle([mylat,mylon],mag,{
		color:"red",
		fillColor :"#f03",
		fillOpacity:0.5
	}).addTo(macarte);
	mycircle.bindPopup(date.toISOString())
};
/*******************************************************************************************/
function formOptionSeisme(e)
{
	e.preventDefault();
	dateDebut = document.getElementById('formDateDebutSeisme').value;
	dateFin = document.getElementById('formDateFinSeisme').value;

	minMag = document.getElementById('formMagnitudeMin').value;
	maxMag = document.getElementById('formMagnitudeMax').value;
  //markerClusters.clearLayers();

	var vitesse = document.getElementById('formValeurVitesse').value;
	var unite = document.getElementById('formUniteVitesse').value;

  showInfoSimulation(dateDebut,dateFin,minMag,maxMag);
	macarte.remove();
	initMap();

	//on desactive le panneau lateral
	$('#sidebar').removeClass('active');
	$('.overlay').removeClass('active');






	//myVar = setTimeout(alertFunc, 3000);


};

/*******************************************************************************************/

function onMapClick(e) {
		var url = "http://dbpedia.org/sparql";
		var query = [
			"PREFIX dbo: <http://dbpedia.org/ontology/>",
			"PREFIX dbr: <http://dbpedia.org/resource/>",
			"PREFIX dbp: <http://dbpedia.org/property/>",
			"PREFIX foaf: <http://xmlns.com/foaf/0.1/>",
			"PREFIX geo: <http://www.w3.org/2003/01/geo/wgs84_pos#>",
			"PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>",
			"PREFIX dbpedia-owl: <http://dbpedia.org/ontology/>",
			"SELECT ?city ?info ?language WHERE {",
			"?city a dbpedia-owl:PopulatedPlace;",
			   "geo:lat ?lat;",
			   "geo:long ?long;",
				 "dbo:abstract ?info.",
			"BIND("+e.latlng.lng+" AS ?longbis).",
			"BIND("+e.latlng.lat+" AS ?latbis).",
			"BIND(lang(?info) AS ?language).",
			"BIND(bif:st_distance(",
			   "bif:st_point(?long,?lat),",
			   "bif:st_point(?longbis,?latbis)",
			")AS ?distance).",
			"FILTER(bif:st_intersects( bif:st_point (?long, ?lat), bif:st_point (?longbis, ?latbis), 10))",
			"}",
			"ORDER BY ?distance",
			"LIMIT 1"
		].join(" ");
		var queryUrl = url+"?query="+ encodeURIComponent(query) +"&format=json";
		document.getElementById('coordinate').innerHTML = "("+e.latlng.lat+", "+e.latlng.lng+")";
		document.getElementById('place').innerHTML = "";
		document.getElementById('infoPlace').innerHTML = "";

		$.ajax({
        dataType: "jsonp",
        url: queryUrl,
        success: function( _data ) {
            var results = _data.results.bindings;
            var res = results[0].city.value;
						var parts = res.split('/');
						var city = parts.pop() || parts.pop();

						//on recupere le nom de la ville
						document.getElementById('place').innerHTML = city;

						//on recupere des infos sur la ville
						var infoFinded = 0;
						for(var i in results)
						{
							if(results[i].language.value == "fr")
							{
								document.getElementById('infoPlace').innerHTML = results[i].info.value;
								infoFinded = 1;
								break;
							}
						}
						if(infoFinded == 0)
						{
							for(var i in results)
							{
								if(results[i].language.value == "en")
								{
									document.getElementById('infoPlace').innerHTML = results[i].info.value;
									infoFinded = 1;
									break;
								}
							}
						}
        }
    });

}

/*******************************************************************************************/
var testExist=false;
var markerPosition
function formLatLong(e)
{
	e.preventDefault();
	var lat = document.getElementById('formLatitude').value;
	var long = document.getElementById('formLongitude').value;

	//on desactive le panneau lateral
	$('#sidebar').removeClass('active');
	$('.overlay').removeClass('active');

	macarte.flyTo([lat,long]);

	// pour eviter de rajouter plusieurs markers,
	// on supprimer l'ancien marker avant de rajouter un nouveau

	// ce cas arrivera une seul fois

	if(testExist==true){
		markerPosition.remove(macarte)
	}
	testExist=true;
	markerPosition = L.marker([lat,long]).addTo(macarte);
	markerPosition.bindPopup("Théo a selectioné ce lieu !!");

	//L.marker([saveLat,saveLong]).removeTo(macarte)
}
/*******************************************************************************************/
function formCityCountry(e)
{
	e.preventDefault();
	var city = document.getElementById('formCity').value;
	var country = document.getElementById('formCountry').value;
	var url = "http://dbpedia.org/sparql";
	var query;
	if(city != "" && country != "")
	{
		query = [
			"PREFIX bif: <bif:>",
			"PREFIX dbo: <http://dbpedia.org/ontology/>",
			"PREFIX dbpedia-owl: <http://dbpedia.org/ontology/>",
			"PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>",
			"PREFIX geo: <http://www.w3.org/2003/01/geo/wgs84_pos#>",
			"select distinct ?lat ?long where {",
			  "?cityPage rdfs:label ?city;",
			        "dbo:country ?countryPage;",
			        "geo:lat ?lat;",
			        "geo:long ?long.",
			  "?countryPage rdfs:label ?country.",
			  "?city bif:contains \"'"+city+"'\".",
			  "?country bif:contains \"'"+country+"'\".",
			"OPTIONAL{?cityPage dbo:populationTotal ?population}",
			"}",
			"ORDER BY DESC (?population)",
			"LIMIT 1"
		].join(" ");

		var queryUrl = url+"?query="+ encodeURIComponent(query) +"&format=json";

		$.ajax({
				dataType: "jsonp",
				url: queryUrl,
				success: function( _data ) {
						var results = _data.results.bindings;
						var lat = results[0].lat.value;
						var long = results[0].long.value;

						//on desactive le panneau lateral
		        $('#sidebar').removeClass('active');
		        $('.overlay').removeClass('active');

						macarte.flyTo([lat,long],12);
				}
		});
	}
	else if(city != "")
	{
		query = [
			"PREFIX bif: <bif:>",
			"PREFIX dbo: <http://dbpedia.org/ontology/>",
			"PREFIX dbpedia-owl: <http://dbpedia.org/ontology/>",
			"PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>",
			"PREFIX geo: <http://www.w3.org/2003/01/geo/wgs84_pos#>",
			"select distinct ?lat ?long where {",
			  "?cityPage rdfs:label ?city;",
			        "geo:lat ?lat;",
			        "geo:long ?long.",
			  "?city bif:contains \"'"+city+"'\".",
			"OPTIONAL{?cityPage dbo:populationTotal ?population}",
			"}",
			"ORDER BY DESC (?population)",
			"LIMIT 1"
		].join(" ");

		var queryUrl = url+"?query="+ encodeURIComponent(query) +"&format=json";

		$.ajax({
				dataType: "jsonp",
				url: queryUrl,
				success: function( _data ) {
						var results = _data.results.bindings;
						var lat = results[0].lat.value;
						var long = results[0].long.value;

						//on desactive le panneau lateral
		        $('#sidebar').removeClass('active');
		        $('.overlay').removeClass('active');

						macarte.flyTo([lat,long],12);
				}
		});
	}
	else if(country != "")
	{
		query = [
			"PREFIX bif: <bif:>",
			"PREFIX dbo: <http://dbpedia.org/ontology/>",
			"PREFIX dbpedia-owl: <http://dbpedia.org/ontology/>",
			"PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>",
			"PREFIX geo: <http://www.w3.org/2003/01/geo/wgs84_pos#>",
			"select distinct ?lat ?long where {",
			  "?cityPage rdfs:label ?country;",
			        "geo:lat ?lat;",
			        "geo:long ?long.",
			  "?country bif:contains \"'"+country+"'\".",
			"OPTIONAL{?cityPage dbo:populationTotal ?population}",
			"}",
			"ORDER BY DESC (?population)",
			"LIMIT 1"
		].join(" ");

		var queryUrl = url+"?query="+ encodeURIComponent(query) +"&format=json";

		$.ajax({
				dataType: "jsonp",
				url: queryUrl,
				success: function( _data ) {
						var results = _data.results.bindings;
						var lat = results[0].lat.value;
						var long = results[0].long.value;

						//on desactive le panneau lateral
		        $('#sidebar').removeClass('active');
		        $('.overlay').removeClass('active');

						macarte.flyTo([lat,long],5);
				}
		});
	}

}

/*******************************************************************************************/
window.onload = function(){
  // Fonction d'initialisation qui s'exécute lorsque le DOM est chargé

  //myUrlQuery=CreateQuery(dateDebut,dateFin,minMag,maxMag);
	//getJsonData(myUrlQuery);
  showInfoSimulation(dateDebut,dateFin,minMag,maxMag);
  initMap();
	//initMap2();
	macarte.on('click', onMapClick);

	document.getElementById('formLatLong').addEventListener('submit', function(e)
		{
			formLatLong(e);
  	});

	document.getElementById('formCityCountry').addEventListener('submit', function(e)
		{
			formCityCountry(e);
  	});

	document.getElementById('formOptionSeisme').addEventListener('submit', function(e)
		{
			formOptionSeisme(e);
  	});
};






//permet de rafraichir les tuiles grises lors du chargement de la map
$("a[href='#menu1']").on('shown.bs.tab', function(e) {
  macarte.invalidateSize();
});
