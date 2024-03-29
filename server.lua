RegisterCommand('setgreenting', function(source, args, raw)
   local identifier = GetPlayerIdentifierByType(source, 'license')
   local greeting = string.sub(raw, 13)

   --https://overextended.github.io/docs/oxmysql/Usage/insert
   MySQL.insert('INSERT INTO greetings (identifier,greeting) VALUES (?,?) ON DUPLICATE KEY  UPDATE greeting = ?', {
      identifier,
      greeting,
      greeting
   }, function()
      TriggerClientEvent('chat:addMessage', source, {
         args = { 'your getting to has been saved' }
      })
   end
   )
end, false)


RegisterNetEvent('mg_greeting:show', function()
   local pID = source
   local identifier = GetPlayerIdentifierByType(pID, 'license')

   MySQL.query('SELECT greeting FROM greetings WHERE identifier = ?', {
      identifier,
   }, function(result)
      print(json.encode(result))
   end)
end)
