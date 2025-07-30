# Roblox Backend DataManager System

A modular data and stat management system built for Roblox games using the [Knit framework](https://github.com/Sleitnick/Knit). Designed for scalability, clarity, and maintainability in production environments.

## ✨ Features

- 🔁 Periodic & on-leave autosaving
- 📊 Extendable player stats
- 🛠️ Auto-healing stat structure
- 📡 Real-time updates via Knit signals
- ⚙️ Configurable & service-based architecture

## 📁 Services Overview

- **DataService**  
  Abstracts access to DataStores with safety and structure.

- **PlayerData**  
  Manages per-player data loading/saving with defaults and cleanup.

- **StatService**  
  Handles stat manipulation and broadcasts real-time changes to clients.

## 📦 Usage

Example: Give XP to a player

```lua
StatService:GiveStat(player, "XP", 100, true)
