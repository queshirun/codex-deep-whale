# Codex Deep Whale · DeepSeek Whale-Maid Theme

[中文](README.md) · [English](README.en.md)

This project ports the “Deep Sea Maid Atelier” skin from [dsh-deep-whale](https://github.com/Small-tailqwq/dsh-deep-whale) to [Codex Dream Skin](https://github.com/Fei-Away/Codex-Dream-Skin). It keeps only the whale maid holding a pen and notebook on the right and provides separate daytime and nighttime themes.

| Day | Night |
| --- | --- |
| ![Day theme](themes/maid-atelier-day/background.png) | ![Night theme](themes/maid-atelier-night/background.png) |

## v1.4.6 features

- Preserves the full background while using high-contrast glass surfaces for text, icons, and the composer.
- Adds a fixed-size chibi whale maid at the bottom of the history sidebar. It moves with the sidebar and is clipped by the left window edge when collapsed.
- Removes dark gradient bands around the composer and file-change summary.
- Hides the decorative `Deep Sea Maid Atelier / DEEP WHALE · CODEX` and `WHALE MAID ONLINE / NIGHT SHIFT ONLINE` captions while preserving the native project title, menus, and window controls.
- Removes the theme and author captions from the new-chat page and adds the same chibi whale maid to the collapsed-sidebar hover preview.
- Keeps the “Today, let’s finish the task together” quote inside the composer-safe area so it cannot overflow or cover controls.
- Restores the native Gothic-style unified composer: attachments, text, and footer controls now share one container instead of separate layers.
- Adds a continuous glass layer to the current Codex application-menu titlebar, spanning File / Edit / View / Help through the window-control area while preserving icon clarity and hit targets.
- Adds a dedicated glass backdrop to the “Select project · Project name” control on project new-chat pages without changing its font, size, or text color.
- Adds a translucent glass backdrop to the selected-project folder label above the composer while preserving its native text and icon styling.
- Fixes Dream Skin injector identity detection when the installer is launched from PowerShell 7.
- Both theme packages pass the official Dream Skin package checks on Windows and macOS.

## Downloads

Download the files from [Releases](https://github.com/queshirun/codex-deep-whale/releases/latest):

| File | Purpose |
| --- | --- |
| `codex-deep-whale-complete-v1.4.6.zip` | Recommended for Windows. Includes both themes, the enhanced engine, installer, assets, and license notices. |
| `codex-deep-whale-maid-day-v1.4.6.zip` | Official-format daytime Dream Skin theme. |
| `codex-deep-whale-maid-night-v1.4.6.zip` | Official-format nighttime Dream Skin theme. |
| `SHA256SUMS-v1.4.6.txt` | SHA-256 checksums for the downloads. |

## First-time Windows installation

### 1. Install Codex Dream Skin

Install and start Dream Skin by following the [official Codex Dream Skin instructions](https://github.com/Fei-Away/Codex-Dream-Skin). Version 1.5.0 or later is recommended. Confirm that the Dream Skin icon appears in the Windows system tray.

### 2. Download and extract the complete bundle

Download `codex-deep-whale-complete-v1.4.6.zip` and extract every file to a normal folder. Do not run the installer from inside the Windows ZIP preview.

The extracted directory should contain:

```text
Install-Local-Enhancements.ps1
README.txt
themes/
engine/
assets/
NOTICE.md
LICENSE
CODEX-DREAM-SKIN-LICENSE.txt
```

### 3. Run the enhancement installer

Right-click `Install-Local-Enhancements.ps1` and select **Run with PowerShell**. You can also run this command from the extracted directory:

```powershell
powershell.exe -NoProfile -ExecutionPolicy RemoteSigned -File .\Install-Local-Enhancements.ps1
```

The installer will:

1. Validate the local Dream Skin engine and enhanced CSS;
2. Back up the original `dream-skin.css` under `%LOCALAPPDATA%\CodexDreamSkin\compat-backups`;
3. Install the chibi sidebar layer, dark-band cleanup, header-caption removal, and current Codex UI compatibility rules;
4. Always invoke Dream Skin through Windows PowerShell, including when installation starts from PowerShell 7;
5. Reapply Dream Skin. If Codex was launched without Dream Skin, it will ask permission to restart Codex correctly.

If prompted, save any unsent input and approve the restart. For later restarts, prefer **Apply or reapply** from the Dream Skin tray menu instead of closing Codex and launching it directly from the Start menu.

### 4. Import the day and night themes

1. Right-click the Dream Skin tray icon;
2. Select **Import theme ZIP…**;
3. Import `themes/codex-deep-whale-maid-day-v1.4.6.zip`;
4. Import `themes/codex-deep-whale-maid-night-v1.4.6.zip`;
5. Select either theme under **Saved themes**.

## Switching themes later

After the first installation, switch between the day, night, or other saved themes from the Dream Skin tray menu. **You do not need to run the PS1 installer again for ordinary theme changes.**

Run `Install-Local-Enhancements.ps1` again only when:

- Installing on another Windows computer for the first time;
- A Dream Skin update replaces the enhanced engine CSS;
- The chibi mascot, header-caption removal, or dark-band cleanup stops working;
- Built-in and imported themes both stop rendering and the Dream Skin injector needs recovery.

## Troubleshooting

### All themes stop rendering

Codex was probably launched without Dream Skin's local debugging port. Right-click the Dream Skin tray icon, select **Apply or reapply**, and approve the restart.

### PowerShell blocks script execution

Open a terminal in the extracted directory and use a process-scoped `RemoteSigned` policy:

```powershell
powershell.exe -NoProfile -ExecutionPolicy RemoteSigned -File .\Install-Local-Enhancements.ps1
```

### Enhancements disappear after a Dream Skin update

Extract the latest complete bundle, run the installer once, and select **Apply or reapply** in Dream Skin. Previously imported themes normally do not need to be imported again.

### Verify the download

```powershell
Get-FileHash .\codex-deep-whale-complete-v1.4.6.zip -Algorithm SHA256
Get-Content .\SHA256SUMS-v1.4.6.txt
```

The hashes should match.

## macOS installation

macOS users can import either standard theme ZIP directly:

1. Install and start Codex Dream Skin;
2. Download the day or night theme ZIP from the Release;
3. Select **Import theme ZIP…** in Dream Skin;
4. Apply it from **Saved themes**.

The theme ZIPs pass the official macOS validator. `Install-Local-Enhancements.ps1` is a Windows installer; `engine/macos/dream-skin.css` in the complete bundle is provided for maintainers who want to integrate the same enhancement rules.

## Credits and licenses

Full attribution chain:

1. **Shangshan / 上善** ([Pixiv](https://www.pixiv.net/users/62155430) · [Bilibili](https://b23.tv/8h5L4xz)) — original whale-girl character artist.
2. **ZipZipPipe / zipzip** ([Pixiv](https://www.pixiv.net/users/18604994) · [Bilibili](https://b23.tv/Pnw6nG8)) — DeepSeek maid adaptation.
3. **Small-tailqwq** ([dsh-deep-whale](https://github.com/Small-tailqwq/dsh-deep-whale)) — “Deep Sea Maid Atelier” skin and asset curation.
4. **queshirun** — Codex Dream Skin port, single-character composition, enhancement CSS, and packaging.

The themes, artwork, and related derivatives are distributed under **CC BY-NC-SA 4.0**. See [NOTICE.md](NOTICE.md) and [LICENSE](LICENSE). The enhanced engine CSS is derived from MIT-licensed Codex Dream Skin code; see [compat/CODEX-DREAM-SKIN-LICENSE.txt](compat/CODEX-DREAM-SKIN-LICENSE.txt).

This is an independent community project and is not endorsed by OpenAI, DeepSeek, Codex Dream Skin, or the credited artists.

## Building and validation

Build the two official theme ZIPs:

```powershell
.\scripts\Build-Packages.ps1
```

Build the complete bundle with the enhancement installer:

```powershell
.\scripts\Build-Complete-Bundle.ps1
```

Validate the themes using the official Dream Skin validators:

```powershell
.\scripts\Test-Packages.ps1 `
  -DreamSkinRoot C:\path\to\Codex-Dream-Skin `
  -NodePath C:\path\to\node.exe
```
