# Plan de arreglos — Neovim 0.12

- **Config:** `/home/jacobo/dotfiles/nvim`
- **Neovim verificado:** 0.12.6
- **Fecha:** 2026-10-26
- **Estado:** completado

## Decisiones acordadas

- [x] **Comment.nvim se elimina.** Se pierden `gbc`, `gb`, `gco`, `gcO` y `gcA`; quedan los nativos `gc` y `gcc`. No se reimplementan.
- [x] **Formatters que faltan se instalan** (Mason/npm): `stylua`, `black`, `isort`, `yamlfix`, `goimports`, `eslint_d`, `sql-formatter`.
- [x] **Cada atajo que cambie conserva un alias del antiguo** y avisa una vez por sesión del nuevo.
- [x] **`gr` no se toca.** Cambiarlo a `grr` y dejar `gr` de alias reintroduce el retraso de `timeoutlen`; se documenta y se usan `grr`/`gra` nativos.
- [x] No se cambia de gestor de plugins: se mantiene `vim.pack`.
- [x] No se migran telescope/nvim-tree/noice en esta tanda (solo se documentan como opción futura).

---

## Resultado final

| Métrica | Antes | Después |
|---|---|---|
| Arranque (`nvim --headless`) | ~190–250 ms | **~90–100 ms** |
| Parsers tree-sitter instalados | 7 (solo del sistema) | **32** |
| `highlighter` en `.ts` / `.go` / `.py` | `nil` | **activo** |
| Autocompletado LSP | desactivado | **vtsls + `omnifunc` + `complete+=o`** |
| Formatters disponibles | 3 de 10 | **10 de 10** |
| Swap de splits | plugin `vim-windowswap` | **módulo Lua en `<leader>m` (2 pasos, conserva tamaños)** |

Plugins eliminados de la config y del disco (`vim.pack.del`): `Comment.nvim`, `vim-windowswap`, `vim-HiLinkTrace`.

Commits:

```
caf9f02 fix(nvim): restore treesitter parsers and highlighting
04ab871 refactor(nvim): drop plugins superseded by 0.12
ae5c644 fix(nvim): enable native LSP completion and skip npm at startup
0a50af0 docs(nvim): add 0.12 cleanup plan
cead729 fix(nvim): make on-save formatting work with installed tools
835e9d1 refactor(nvim): drop duplicate and default options
2191f89 fix(nvim): align lualine with global statusline
e0f91cf docs(nvim): record results of the 0.12 fixes
f3a710a fix(nvim): swap buffers between splits preserving sizes
ec5289d docs(nvim): document size-preserving window swap
7bde9b6 feat(nvim): replace eslint/prettier with oxlint/oxfmt
e8a2f2d feat(nvim): reimplement HiLinkTrace commands
de5ae55 refactor(nvim): load dadbod eagerly
5e39a65 feat(nvim): support cross-tab buffer swaps
```

---

## Fase 1 — Base y medición

- [x] Revisar estado de git (`nvim/` limpio).
- [x] Medir arranque base: **~190–250 ms**; `options+keymaps` solos: **~3 ms**; `npm root -g`: **80–115 ms**.
- [x] Medición final: **~90–100 ms**.

## Fase 2 — Tree-sitter

Archivos: `plugin_config/treesitter.lua`, `plugins.lua`

- [x] Sustituir `vim.treesitter.language.install(...)` (no existe en 0.12) por `require("nvim-treesitter").install({...})`.
- [x] Separar lista de **parsers** (para instalar) de **filetypes** (para `FileType`).
- [x] Añadir `vim.treesitter.start(ev.buf)` tras comprobar el parser con `vim.treesitter.language.get_lang()` + `language.add()`.
- [x] Añadir hook en `PackChanged`: al actualizar `nvim-treesitter`, ejecutar `require("nvim-treesitter").update()`.
- [x] Instalar parsers (`install():wait()` → `ok=true`, 32 parsers).
- [x] Verificar:
  - [x] `:checkhealth vim.treesitter` → `go`, `python`, `tsx`, `typescript`, `vue` OK.
  - [x] `highlighter ~= nil` en `.lua`, `.ts`, `.go`, `.py`, `.md`.
  - [x] `nvim-treesitter-context` usa los parsers nuevos.

## Fase 3 — Autocompletado LSP

Archivos: `plugin_config/lsp.lua`, `options.lua`

- [x] Quitar `vim.lsp.completion.enable()` sin argumentos (desactivaba).
- [x] Añadir `LspAttach` con `vim.lsp.completion.enable(true, client.id, ev.buf)`.
- [x] Añadir `o` a `'complete'` para que `'autocomplete'` incluya LSP vía `omnifunc`.
- [x] Actualizar `'completeopt'` con `nearest`.
- [x] Verificar en `.ts`: cliente `vtsls`, `completionProvider=true`, `omnifunc=v:lua.vim.lsp.omnifunc`, `complete=.,w,b,u,t,o`.
- [x] Los mapeos de `<Tab>`/`<S-Tab>` se mantienen.

## Fase 4 — Arranque: `npm root -g`

Archivo: `plugin_config/lsp.lua`

- [x] Resolver `@vue/language-server` con rutas conocidas (`~/.npm-packages`, Mason).
- [x] Ejecutar `npm root -g` solo como último recurso.
- [x] Medir de nuevo: **~90–100 ms** (antes ~190–250 ms).

## Fase 5 — Formatters

Archivo: `plugin_config/conform.lua`

- [x] Instalar con Mason: `stylua`, `black`, `isort`, `yamlfix`, `goimports`, `eslint_d`, `sql-formatter`.
- [x] Cambiar formatter `eslint` → `eslint_d`.
- [x] Poner `notify_on_error = true`.
- [x] Verificar con `:checkhealth conform` (10/10 OK) y formateando `.lua`, `.py`, `.go`, `.yaml`, `.sql`.

## Fase 6 — Limpieza y atajos

### 6.1 Plugins cubiertos por 0.12

- [x] `numToStr/Comment.nvim` → nativo `gc`/`gcc`.
- [x] `wesQ3/vim-windowswap` → reimplementado en Lua (ver Fase 8). `<C-w>x` nativo no era equivalente.
- [x] `gerw/vim-HiLinkTrace` → `:Inspect` / `:InspectTree`.
- [x] `vim.g.windowswap_map_keys` y `require("Comment").setup()` fuera.
- [x] Borrar plugins del disco con `vim.pack.del({...}, { force = true })`; lockfile limpio.

### 6.2 Alias + notificación (una vez por sesión)

- [x] `<leader>m` → swap de buffers en dos pasos (marca/intercambia), conserva tamaños.
- [x] `<leader>hh` → alias de `<leader>hi` (`:Inspect`); notifica “Nuevo atajo: `<leader>hi`”.
- [x] Helper `notify_once` para no repetir el aviso.
- [x] Probados ambos callbacks: sin errores y con notificación.

### 6.3 Otros ajustes

- [x] `lualine`: `globalstatus = true`.
- [x] `dadbod`: relanzar el comando en `CmdUndefined` (el primer `<leader>db` ya funciona).
- [x] `conform`: añadido en `plugins.lua`; eliminado el `VimEnter`.
- [x] `outline`: `setup()` solo la primera vez.
- [x] `options.lua`: quitados defaults, duplicados y `secure`.
- [x] `options.lua`: `backspace` fuera (el default ya era `indent,eol,start`); `have_nerd_font` fuera.
- [x] Añadidos `winborder = "rounded"` y `pumborder = "rounded"`.
- [x] Revisados `history = 700` y `foldmethod`/`foldlevel`: se dejan como estaban (elección del usuario).

## Fase 7 — Verificación final

- [x] Arranque medido y comparado (**~90–100 ms**).
- [x] `:checkhealth vim.treesitter` y `:checkhealth conform` sin errores.
- [x] `.lua`, `.ts`, `.go`, `.py`, `.yaml`, `.sql` con highlighting, LSP y formato.
- [x] `vim.pack` sin errores y lockfile coherente.
- [x] `git diff` revisado por commits.

## Fase 8 — Swap de buffers entre splits

- [x] Detectar que `<C-w>x` no cruza layouts mixtos (solo intercambia en la misma fila/columna).
- [x] Implementar `plugin_config/window_swap.lua`: marca una ventana y en la segunda pulsación intercambia buffers.
- [x] Conservar tamaños del layout y la vista (`winsaveview`) de cada buffer.
- [x] Mapear `<leader>m` al swap en dos pasos; `<C-w>x` se queda nativo.
- [x] Probar con `vsplit` + `split`: buffers intercambiados, anchos/alturas intactos, foco y vistas conservados.
- [x] Manejar cancelación en la misma ventana y ventana marcada cerrada (el cambio de pestaña ya no cancela, ver Fase 9).
- [x] Commit: `fix(nvim): swap buffers between splits preserving sizes`.

## Fase 9 — Follow-up: oxlint/oxfmt, HLT, cross-tab y dadbod

- [x] Sustituir `eslint`/`prettier` por `oxlint`/`oxfmt` en conform y en el LSP.
- [x] Instalar `oxlint` y `oxfmt` con Mason.
- [x] Añadir `javascriptreact`/`typescriptreact`: las claves `jsx`/`tsx` anteriores no coincidían con el filetype real.
- [x] Configurar `oxlint` con `cwd` al proyecto (`.oxlintrc.json`/`package.json`).
- [x] Reimplementar `:HLT`, `:HLT!` y `:HLTm`: syntax stack, capturas de treesitter, cadena de links y `fg`/`bg`.
- [x] Restaurar `<leader>hh` a `:HLT`; `<leader>hi` sigue como `:Inspect`.
- [x] Soporte de swap entre pestañas (marcar en una tab y cambiar a otra).
- [x] Dadbod eager para conservar los argumentos del comando.
- [x] Verificado: oxfmt en JS/TS/JSX/TSX/Vue/HTML/JSON, LSP `oxlint`, `:HLT`/`:HLT!`, cross-tab y `:DBUI`.

---

## Notas / pendientes fuera de esta tanda

- Migraciones opcionales: telescope → fzf-lua/snacks.picker, nvim-tree → oil/mini.files, noice → snacks.notifier.
- `gr` se queda como está (telescope references). Si se quiere eliminar el retraso de `timeoutlen`, usar `grr` nativo y borrar el mapeo.
- `<C-w>x` sigue nativo: solo intercambia dentro de la misma fila/columna. Para cruzar layouts mixtos, usar `<leader>m`.
- `diffview.nvim`, `vim-rhubarb` y `pack-ui.nvim` se mantienen hasta confirmar uso.
- El lockfile de `vim.pack` vive en `~/.config/nvim/nvim-pack-lock.json`, fuera del repo de dotfiles.
- `oxfmt` es 0.x y `oxlint` no cubre el 100% de reglas/plugins de ESLint. `eslint_d`/`prettier` siguen instalados pero ya no se usan; si algún proyecto necesita una regla no soportada, se puede reactivar `eslint_d` solo para ese caso.
