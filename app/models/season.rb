class Season < ActiveRecord::Base
	has_many :leagues
	has_many :teams, through: :leagues
	has_many :matches, through: :leagues
	has_many :participants
	has_many :games, through: :matches

	def results
		res = Hash.new
		games.each do |game|
			res[game.black_id] ||= Array.new
			res[game.white_id] ||= Array.new
			free = 0
			free += 1 while res[game.black_id][free] || res[game.white_id][free]
			res[game.black_id][free] = [game, game.white_id, game.black_result]
			res[game.white_id][free] = [game, game.black_id, game.white_result]
		end
		res.each_with_index do |(pid,games), i|
			games.each_with_index do |game, j|
				if game.nil?
					res[pid][j] = [nil, nil, '=', 0]
				else
					res[game[1]][j] << i+1
				end
			end
		end
		res.map.with_index do |(pid,games), i|
			"#{i+1}\t" + 
			"%-30s" % (participants.find(pid).lastname + ' ' + participants.find(pid).firstname) + "\t" +
			games.map do |game|
				"#{game[3]}#{game[2]}"
			end.join("\t")
			# games.map do |game|
			# 	"#{game}"
			# end.join("\t")
		end
	end

end
