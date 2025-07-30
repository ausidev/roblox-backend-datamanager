# DataManager Backend System

This backend system handles **persistent player data** and **stat management** using Roblox’s `DataStoreService`, built on top of the [Knit framework](https://github.com/Sleitnick/Knit). It features:

- ✅ Modular service-based structure (`DataService`, `PlayerData`, `StatService`)  
- 🔁 Autosave & leave-save handling  
- 📊 Extendable stat definitions  
- 🧹 Data sanitization & self-healing templates  
- 📡 Client sync using Knit signals  
- ⚠️ Backend-first logic to prevent exploits  

---

## Example Usage: Adding XP to a Player

```lua
-- Server-side example
local StatService = Knit.GetService("StatService")

-- Add 100 XP to a player (Step = true means additive)
StatService:GiveStat(player, "XP", 100, true)
