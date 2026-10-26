# Plan de arreglos — Neovim 0.12

- **Config:** `/home/jacobo/dotfiles/nvim`
- **Neovim verificado:** 0.12.6
- **Fecha:** 2026-10-26
- **Estado:** en progreso (pausado para revisión)

## Decisiones acordadas

- [x] **Comment.nvim se elimina.** Se pierden `gbc`, `gb`, `gco`, `gcO` y `gcA`; quedan los nativos `gc` y `gcc`. No se reimplementan.
- [x] **Formatters que faltan se instalan** (Mason/npm): `stylua`, `black`, `isort`, `yamlfix`, `goimports`, `eslint_d`, `sql-formatter`.
- [x] **Cada atajo que cambie conserva un alias del antiguo** y avisa una vez por sesión del nuevo.
- [x] **`gr` no se toca.** Cambiarlo a `grr` y dejar `gr` de alias reintroduce el retraso de `timeoutlen`; se documenta y se usan `grr`/`gra` nativos.
- [x] No se cambia de gestor de plugins: se mantiene `vim.pack`.
- [x] No se migran telescope/nvim-tree/noice en esta tanda (solo se documentan como opción futura).

---

## Estado actual

Archivos tocados hasta ahora:

```
 M nvim/options.lua
 M nvim/plugin_config/lsp.lua
 M nvim/plugin_config/treesitter.lua
 M nvim/plugins.lua
```

Para revisar: `cd ~/dotfiles && git diff -- nvim`

Pendiente inmediato: verificar que los parsers/formatters se instalaron, terminar la limpieza de opciones y los ajustes de `lualine`, `dadbod`, `conform` y `outline`.

---

## Fase 1 — Base y medición

- [x] Revisar estado de git (`nvim/` limpio).
- [x] Medir arranque base: `nvim --headless --startuptime`.
  - Base medida: **~190–250 ms**; `options+keymaps` solos: **~3 ms**; `npm root -g`: **80–115 ms**.
- [ ] Guardar medición final para comparar.

## Fase 2 — Tree-sitter (bug principal)

Archivo: `plugin_config/treesitter.lua`, `plugins.lua`

- [x] Sustituir `vim.treesitter.language.install(...)` (no existe en 0.12) por `require("nvim-treesitter").install({...})`.
- [x] Separar lista de **parsers** (para instalar) de **filetypes** (para `FileType`).
- [x] Añadir `vim.treesitter.start(ev.buf)` tras comprobar el parser con `vim.treesitter.language.get_lang()` + `language.add()`.
- [x] Añadir hook en `PackChanged`: al actualizar `nvim-treesitter`, ejecutar `require("nvim-treesitter").update()`.
- [x] Instalar parsers ahora (`install():wait()` → `ok=true`).
- [ ] Verificar:
  - [ ] `:checkhealth vim.treesitter`.
  - [ ] `highlighter ~= nil` en `.lua`, `.ts`, `.go`, `.py`.
  - [ ] `nvim-treesitter-context` funciona en TS/Go.

## Fase 3 — Autocompletado LSP

Archivo: `plugin_config/lsp.lua`, `options.lua`

- [x] Quitar `vim.lsp.completion.enable()` sin argumentos (actualmente **desactiva**).
- [x] Añadir `LspAttach` con `vim.lsp.completion.enable(true, client.id, ev.buf)`.
- [x] Añadir `o` a `'complete'` para que `'autocomplete'` incluya LSP vía `omnifunc`.
- [x] Actualizar `'completeopt'` con `nearest` (nuevo en 0.12).
- [ ] Mantener los mapeos de `<Tab>`/`<S-Tab>` (ya funcionan con `pumvisible`); verificar en un `.ts`.
- [ ] Verificar en un `.ts`: menú automático + `<C-y>` acepta.

## Fase 4 — Arranque: `npm root -g`

Archivo: `plugin_config/lsp.lua`

- [x] Resolver `@vue/language-server` con rutas conocidas (`~/.npm-packages`, Mason).
- [x] Ejecutar `npm root -g` solo como último recurso (o eliminarlo si las rutas existen).
- [ ] Medir de nuevo el arranque y comparar.

## Fase 5 — Formatters

Archivo: `plugin_config/conform.lua`

- [ ] Verificar instalación Mason de: `stylua`, `black`, `isort`, `yamlfix`, `goimports`, `eslint_d`, `sql-formatter`.
- [ ] Cambiar formatter `eslint` → `eslint_d` (el binario `eslint` no existe).
- [ ] Poner `notify_on_error = true` (o dejar aviso visible si falla).
- [ ] Verificar con `:ConformInfo` y formateando un `.lua`, `.py`, `.go`, `.yaml`, `.sql`.

## Fase 6 — Limpieza y atajos

### 6.1 Quitar plugins ya cubiertos por 0.12

- [x] `numToStr/Comment.nvim` → nativo `gc`/`gcc` (decisión: sin alias para `gbc`).
- [x] `wesQ3/vim-windowswap` → nativo `<C-w>x`.
- [x] `gerw/vim-HiLinkTrace` → `:Inspect` / `:InspectTree`.
- [x] `vim.g.windowswap_map_keys` y `require("Comment").setup()` fuera.
- [ ] Borrar plugins del disco con `vim.pack.del(...)` y comprobar lockfile.

### 6.2 Alias + notificación (una vez por sesión)

- [x] `<leader>m` → alias de `<C-w>x`; notifica “Nuevo atajo: `<C-w>x`”.
- [x] `<leader>hh` → alias de `<leader>hi` (`:Inspect`); notifica “Nuevo atajo: `<leader>hi`”.
- [x] Helper `notify_once` para no repetir el aviso.

### 6.3 Otros ajustes

- [ ] `lualine`: `globalstatus = true` (coherente con `laststatus = 3`).
- [ ] `dadbod`: reejecutar el comando en `CmdUndefined` (el primer `<leader>db` no hacía nada).
- [ ] `conform`: añadirlo en `plugins.lua` y quitar el `VimEnter` (no aporta y puede pedir confirmación).
- [ ] `outline`: no repetir `setup()` en cada pulsación.
- [ ] `options.lua`: quitar defaults (`magic`, `showcmd`, `autoread`, `smarttab`, `hlsearch`, `incsearch`, `timeout`, `backup`, `background`), duplicados (`updatetime`, `signcolumn`, `timeoutlen`) y `secure`.
- [ ] `options.lua`: `backspace` explícito o fuera; `have_nerd_font` fuera.
- [x] Añadir `winborder = "rounded"`; mantener `pumborder`.
- [ ] Revisar `history = 700` (default 10000) y `foldmethod`/`foldlevel` (se dejan como están si son intencionados).

## Fase 7 — Verificación final

- [ ] `nvim --headless --startuptime` y comparar con la base.
- [ ] `:checkhealth` (treesitter, lsp, conform).
- [ ] Abrir `.lua`, `.ts`, `.go`, `.py`, `.yaml` y comprobar highlighting, LSP y formato.
- [ ] `vim.pack` sin errores y lockfile coherente.
- [ ] Resumen de cambios + `git diff` para revisión.

---

## Notas / pendientes fuera de esta tanda

- Migraciones opcionales: telescope → fzf-lua/snacks.picker, nvim-tree → oil/mini.files, noice → snacks.notifier.
- `gr` se queda como está (mapeo a telescope references) para no perder el alias; si se quiere eliminar el retraso, usar `grr` nativo y borrar el mapeo.
- `diffview.nvim`, `vim-rhubarb` y `pack-ui.nvim` se mantienen hasta confirmar uso.
