require 'httparty'
require 'nokogiri'

xls_list = [
	# ["MTB RACER","https://strava.app.link/yXqYMOVh8eb","","https://www.strava.com/activities/5054734508"],
	# ["ValeX3","https://www.strava.com/activities/5054728957","https://strava.app.link/zSUFau1h8eb","https://strava.app.link/zSUFau1h8eb"],
	# ["Los Viejos Cleteros","","",""],
	# ["Jaufbike","https://strava.app.link/B4IboJ4i8eb","https://strava.app.link/mt0uQ4xi8eb","https://www.strava.com/activities/5054771099"],
	# ["The Drink Team (Lara Biker’s) ","https://strava.app.link/cbruliOX7eb","https://strava.app.link/FaXaDqwY7eb","https://strava.app.link/RmyWgK9Y7eb"],
	# ["Temukanos","Fueron enviadas por Whatsapp","",""],
	# ["Montañistas","https://strava.app.link/EH97oaz37eb","https://strava.app.link/tTXcoI427eb","https://strava.app.link/ZyScvRP27eb"],
	# ["PANAMERICLETA ","https://strava.app.link/w2CWeSQi8eb","",""],
	# ["ACABikes","https://strava.app.link/7wzp4wPW7eb","https://strava.app.link/O0SI9sQi8eb","https://strava.app.link/Vv3H7CBZ7eb"],
	# ["Hain bike","","",""],
	# ["Ironcycling ","https://www.strava.com/activities/5054734812","https://www.strava.com/activities/5054797462","https://www.strava.com/activities/5054801009"],
	# ["Llego el Bigote","https://www.strava.com/activities/5054986219","https://www.strava.com/activities/5054744486","https://www.strava.com/activities/5054892658"],
	# ["Venus Bike","https://strava.app.link/JrsOagk17eb","https://strava.app.link/FE8ds6T07eb","https://www.strava.com/activities/5054725009"],
	# ["Culero's Tim","https://strava.app.link/KNceYJxk8eb","https://strava.app.link/pWsidoyk8eb","https://www.strava.com/activities/5054743656"],
	# ["PincheCoronaBikers","https://strava.app.link/6Ral0cOW7eb","https://strava.app.link/QXUzXw2W7eb","https://strava.app.link/bRGU772W7eb"],
	# ["Plano Falso","https://www.strava.com/activities/5054726924","https://www.strava.com/activities/5054733011","https://www.strava.com/activities/5054727340"],
	# ["marvidente","https://strava.app.link/trngiBzj8eb","https://www.strava.com/activities/5054733831","https://www.strava.com/activities/5054734629"],
	# ["Ride Chicureo","https://www.strava.com/activities/5054759470","https://www.strava.com/activities/5054734317","https://www.strava.com/activities/5054733110"],
	# ["Los Pata E'fierro-","https://www.strava.com/activities/5054734251?","https://www.strava.com/activities/5054799611?","https://www.strava.com/activities/5054739984?"],
	# ["LarabikerMix ","https://strava.app.link/nnCSZ5sk8eb","https://strava.app.link/EysIOanj8eb","https://strava.app.link/9DrQbp1k8eb"],
	# ["MANKEBIKE","https://strava.app.link/PdeR1jSl8eb","",""],
	# ["Electrobike","https://strava.app.link/eJ7JJ15W7eb","https://www.strava.com/activities/5054729942","https://strava.app.link/5TDMYOC87eb"],
	# ["Trinirbk","https://strava.app.link/Jikn3g3m8eb","https://strava.app.link/1lXsNwNm8eb","https://strava.app.link/qRahKqcn8eb"],
	# ["Team mapu ruta 2","https://strava.app.link/6QSJGrV27eb","https://strava.app.link/cgBvky527eb","https://strava.app.link/7AeWZtPW7eb"],
	# ["Quienchuchamemanda team","https://strava.app.link/CZrevvXn8eb","https://strava.app.link/XaVGkkZn8eb","https://strava.app.link/BYVQTWio8eb"],
	# ["Las vecinas","https://strava.app.link/qOiDciAo8eb","https://www.strava.com/activities/5056850191","https://www.strava.com/activities/5055463811"],
	# ["Los bebos ","https://strava.app.link/qyiIpRso8eb","https://strava.app.link/51tR8tBo8eb","https://strava.app.link/PX7BtOuo8eb"],
	# ["malitosdelacabeza","https://www.strava.com/activities/5054732038","https://www.strava.com/activities/5054836894","https://www.strava.com/activities/5054723220"],
	# ["Fat_Ciclists","https://strava.app.link/GGg13Wkq8eb","https://strava.app.link/AUexCtZm8eb","https://strava.app.link/4WAvytdn8eb"],
	# ["Tripletsbike","https://strava.app.link/jzslJcx47eb","https://strava.app.link/nwHTLhem8eb","https://strava.app.link/VWpX5D3p8eb"],
	# ["BreakingBad","https://strava.app.link/cJy4tlJW7eb","https://strava.app.link/iarNQLdX7eb","https://strava.app.link/6XJQiduX7eb"],
	# ["Los Fixones","https://strava.app.link/gNcTeets8eb","https://www.strava.com/activities/5055164548","https://www.strava.com/activities/5054736393"],
	# ["The george best cycling team","https://strava.app.link/K65gzVit8eb","https://strava.app.link/MiKGMijY7eb","https://strava.app.link/fijKZ26W7eb"],
	# ["Los bicicleteros","https://strava.app.link/ruqdC8uj8eb","https://strava.app.link/hU1yQgEj8eb","https://strava.app.link/NcOwDMvt8eb"],
	# ["Los terrible fixa ","https://strava.app.link/K0OYpqSs8eb","https://www.strava.com/activities/5054717601","https://www.relive.cc/view/vMv8QrwGLNO"],
	# ["Shimalos","https://strava.app.link/yuvTqsCu8eb","https://strava.app.link/9QSIDjNu8eb","https://www.strava.com/activities/5054745101"],
	# ["Los minimos ","https://strava.app.link/VhyMP7KW7eb","https://strava.app.link/7G3y6MKl8eb","https://strava.app.link/RESM2o8t8eb"],
	# ["Mugiwaras Pro Racing Team","https://strava.app.link/ZaIyxh1v8eb","https://strava.app.link/RvnwzFSv8eb","https://strava.app.link/qIyZBf2v8eb"],
	# ["Pedaleros Aconcagua","https://strava.app.link/GQEfIuay8ebl","https://strava.app.link/1RWKfxRq8eb","https://strava.app.link/kGGGlAXW7eb"],
	# ["Family Flowers ","https://strava.app.link/zzrxqfTY7eb","https://strava.app.link/1Muv6Yvy8eb","https://www.strava.com/activities/5053524595"],
	# ["Los CortaCalle","https://strava.app.link/1JJDvGxX7eb","https://strava.app.link/NnowQirX7eb","https://strava.app.link/MFwYoUrX7eb"],
	# ["ACABikes","https://strava.app.link/7wzp4wPW7eb","https://strava.app.link/O0SI9sQi8eb","https://strava.app.link/Vv3H7CBZ7eb"],
	# ["malditalisiadaAudaxRandonneur","https://www.strava.com/activities/5054735474","https://www.strava.com/activities/5054947379","https://www.strava.com/activities/5055009245"],
	# ["Molinabike","https://www.strava.com/activities/5054741575","Luis Díaz González","Paulo Navarro"],
	# ["Huevos semicocidos","https://strava.app.link/sLn3S7Rz8eb","https://strava.app.link/GgBeRePW7eb","https://www.strava.com/activities/5054736503"],
	# ["No hay","https://strava.app.link/SCwpCeXB8eb","",""],
	["MUGIWARAS PRO RACING TEAM","https://strava.app.link/qIyZBf2v8eb","https://strava.app.link/ZaIyxh1v8eb","https://strava.app.link/qwJS4iJw8eb"],
	["FlowLAK","https://strava.app.link/gpYc6Vw37eb","https://strava.app.link/zJXIkaf97eb","https://strava.app.link/hO41GNs37eb"],
	["Km 20 mtb","https://www.strava.com/activities/5054772399","https://strava.app.link/tjvu98JE8eb","https://www.strava.com/activities/5054732020"],
	["Quilipedal","La enviamos Rodrigo Rojo Castro ","La enviamos Fidel Arias ","Enviada Diego Castro "],
	["Perro Guatòn","https://strava.app.link/oRQBpEgk8eb","https://strava.app.link/AKlQPB1j8eb","https://strava.app.link/Ao7OHNzZ7eb"],
	["Panzocletos","https://strava.app.link/rZ4FECsE8eb","https://strava.app.link/jZGKs4KE8eb","https://strava.app.link/8snay8CH8eb"],
	["ACROSSANDES ","https://www.strava.com/activities/5055330728","https://www.strava.com/activities/5055525307","https://www.strava.com/activities/5055143120"],
	["Chicureo Ride","https://www.strava.com/activities/5054759470","https://www.strava.com/activities/5054734317","https://www.strava.com/activities/5054733110"],
	["Dream Team","https://www.strava.com/activities/5054777742","https://www.strava.com/activities/5055052665","https://www.strava.com/activities/5054733203"],
	["Malatesta Audax Club","https://strava.app.link/HNsoC66H8eb","https://strava.app.link/kFc9Vgs87eb","https://strava.app.link/lipycmb87eb"],
	["Los Marraquetas","https://www.strava.com/activities/5055786830","https://www.strava.com/activities/5055723690","https://www.strava.com/activities/5055831469"],
	["El Arrayan De Maipu","62 Kilometro","62 Kilometro","62 Kilometro"],
	["Quilipedal","https://strava.app.link/JOxLk9pP8eb","https://strava.app.link/xMbWV1OO8eb","https://strava.app.link/aGAZkN0M8eb"],
	["TEAM 5AM","https://www.strava.com/activities/5054735441","https://www.strava.com/activities/5055721840","https://www.strava.com/activities/5054729326"],
	["Los memos bike ","https://strava.app.link/xGnPOrnY8eb","https://strava.app.link/cB6z7XxY8eb","No se guardo (tengo pantallazo) "],
	["@monkeybikes_vitacura ","https://strava.app.link/ZwWVTxLX7eb","https://strava.app.link/WwOYriA17eb","https://connect.garmin.com/modern/activity/6535979225"],
	["Quienchuchamemanda team","https://strava.app.link/CZrevvXn8eb","https://strava.app.link/XaVGkkZn8eb","https://strava.app.link/BYVQTWio8eb"],
	["Chicureo Ride","https://www.strava.com/activities/5054759470","https://www.strava.com/activities/5054734317","https://www.strava.com/activities/5054733110"],
	["Los weed de pso","https://strava.app.link/9HfeZGkE9eb","https://strava.app.link/i670yMKl8eb","https://strava.app.link/R6EtVC5p8eb"],
	["Los Palominos","https://strava.app.link/RV0L6jEz8eb","https://strava.app.link/53A4aHHG8eb","https://strava.app.link/1iJbMbgG8eb"],
	["Dislocadas","https://strava.app.link/1TP5vq207eb","https://strava.app.link/5DogRWVr8eb","https://strava.app.link/iUw9eZVG9eb"],
	["High Bridge","https://strava.app.link/b4gpmUw87eb","https://www.strava.com/activities/5054734768","https://www.strava.com/activities/5054733668"]
]

def strava_url(activity_id)
	"https://www.strava.com/activities/#{activity_id}"
end

def validate_url(xls_url)
	if xls_url.start_with? "https://strava.app.link/"
		# msg = "  ShortLink  | "
		response = HTTParty.get(xls_url).body
		pre_id = response.index "https://www.strava.com/activities/"
		post_id = response.index "/shareable_images"
		raise response if response == "Too Many Requests"
		if pre_id.nil? || post_id.nil?
			# msg += "ERROR with #{xls_url}"
			# puts msg
			nil
		else
			strava_uri = response[pre_id..post_id]
			# puts msg + strava_uri
			strava_uri
		end
	elsif xls_url.start_with? "https://www.strava.com/activities/"
		# puts "  DirectLink | "
		xls_url
	elsif xls_url.empty?
		# puts "  Empty Link"
		nil
	else
		puts "  Not Strava | #{xls_url}"
		nil
	end
end

def parse_list(xls_list)
	teams = []
	xls_list.each do |row|
		team_name, *urls = row
		team  = [team_name]
		puts "\nEquipo [#{team_name}]"
		urls.each_with_index do |url, index|
			msg = " #{index + 1} #{url}"
			if url.empty?
				msg += "EmptyLink: SKIP" 
			else
				strava_uri = validate_url(url)
				if strava_uri
					msg += " [#{strava_uri}] "
					response = HTTParty.get(strava_uri)
					raise response.body if response.body == "Too Many Requests"
					nok = Nokogiri::HTML(response.body)
					km = nok.search("meta[property='fitness:distance:value']")[0]
					if km
						km = km.attributes['content'].value
					else
						km = "-"
					end
					msg += "#{km}"
					team.push km 
				else
					msg += "  no link"
				end
			end
			puts msg
		end
		teams.push team
	end
	puts "\n TEAMS:\n"
	teams.each {|team| puts [team[0], team[1], team[2], team[3]].join(" ")}
rescue RuntimeError => e
	puts "\nBloqueado por Strava :(\n"
	teams.each {|team| puts [team[0], team[1], team[2], team[3]].join(" ")}
end

parse_list(xls_list)