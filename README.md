
---

## 🔌 Features

- 🧠 **Persistent Player Data**: Automatically loads and saves player data with version control.
- 🪙 **Stat Management**: Modify player stats server-side and reflect changes on the client.
- 🔁 **Auto Save Loop**: Periodically saves player data during runtime.
- 📡 **Unreliable Signal Support**: Uses Knit’s `.CreateUnreliableSignal()` for efficient client updates.
- 🔄 **Version Syncing**: Automatically updates old saved data structures.

---

## 🚀 Getting Started

### 🔗 Dependencies

- [Knit Framework](https://github.com/Sleitnick/Knit)

Place `Knit` under `ReplicatedStorage.Packages`.

---

### 🧪 Setup

1. Clone or copy the repository into your Roblox project.
2. Initialize `Knit` in a ServerScript within `ServerScriptService`:
    ```lua
    local Knit = require(game:GetService("ReplicatedStorage").Packages.Knit)
    Knit.Start():catch(warn)
    ```

3. Start `Knit` on the client in a `LocalScript` under `StarterPlayerScripts`:
    ```lua
    local Knit = require(game:GetService("ReplicatedStorage").Packages.Knit)
    Knit.Start():andThen(function()
        print("Knit started on client!")
    end):catch(warn)
    ```

---

## 🛠 Customization

Modify `PlayerData.PlayerStats` to define your game's default stats:
```lua
PlayerStats = {
    TownLevel = 1,
    Gold = 0,
    _version = 1
}
