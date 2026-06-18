awk 'NF {print "{\"meus-jogos\":\""$0"\"}"}' input.txt > games.json
