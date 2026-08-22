Codex Deep Whale v1.4.6 complete compatibility bundle
======================================================

Contents:

1. themes/codex-deep-whale-maid-day-v1.4.6.zip
   Official-format daytime theme for Codex Dream Skin.

2. themes/codex-deep-whale-maid-night-v1.4.6.zip
   Official-format nighttime theme for Codex Dream Skin.

3. Install-Local-Enhancements.ps1
   Installs the chibi sidebar layer, dark-gradient cleanup, header-caption
   removal, and Codex 26.818 compatibility rules. The script backs up the
   original dream-skin.css under compat-backups before writing anything and
   then asks Dream Skin to reapply the skin.

Recommended Windows installation:

1. Install and start Codex Dream Skin 1.5.0 or later.
2. Extract this complete ZIP to a normal directory. Do not run the installer
   from inside the Windows ZIP preview.
3. Right-click Install-Local-Enhancements.ps1 and choose Run with PowerShell.
   If Codex needs a Dream Skin restart, save unsent input and approve it.
4. From the Dream Skin tray menu, choose Import theme ZIP and import one or
   both ZIP files from the themes directory.
5. Select the desired theme under Saved themes.

Command-line installation from the extracted directory:

  powershell.exe -NoProfile -ExecutionPolicy RemoteSigned -File .\Install-Local-Enhancements.ps1

Normal theme switching:

- After first installation, switch day, night, or other saved themes directly
  in Dream Skin. You do not need to run the PS1 again.
- Run the PS1 again only on a new Windows computer, after a Dream Skin update
  replaces the enhanced CSS, or when the enhancement effects stop working.

Recovery:

- If built-in and imported themes both stop rendering, right-click the Dream
  Skin tray icon, choose Apply or reapply, and approve the restart.
- Restart Codex through Dream Skin instead of closing it and launching it
  directly from the Start menu.

Visual behavior:

- The original full background is preserved.
- The decorative Deep Sea Maid Atelier / DEEP WHALE and ONLINE captions are
  hidden while the native project title, menus, and window buttons remain.
- The new-chat theme and author captions are hidden, and the collapsed-sidebar
  hover preview carries the same chibi whale maid as the docked sidebar.
- The theme quote stays inside the composer-safe area and cannot overlap the
  right-side controls.
- Attachments, editable text, and footer controls share the same native
  Gothic-style composer surface without stacked backgrounds or a seam.
- The header and history sidebar use glass surfaces.
- The composer and file-change dark gradient bands are removed.
- The chibi whale maid stays fixed in size, moves with the sidebar, and is
  clipped by the left window edge when the sidebar collapses.

Credits and licenses:

- Original theme and assets: Small-tailqwq/dsh-deep-whale
- Original whale-girl artist: Shangshan / 上善
- DeepSeek maid adaptation: ZipZipPipe / zipzip
- Codex / Dream Skin port: queshirun
- Artwork and theme license: NOTICE.md and LICENSE (CC BY-NC-SA 4.0)
- Enhanced Dream Skin engine CSS license: CODEX-DREAM-SKIN-LICENSE.txt (MIT)
