NEOVIM KEYBINDS

MOST USED

Fuzzy finding
<leader>ff     Find files
<D-p>          Find files, GUI Neovim only / if terminal forwards Cmd-P
<leader>fb     Find open buffers
<leader>fg     Live grep
<leader>gc     Pick Git changed files

Git / diffs
<leader>go     Toggle Git diff overlay
]h             Next Git hunk
[h             Previous Git hunk
]H             Last Git hunk
[H             First Git hunk

LSP / code
gd             Go to definition
gr             Find references
K              Hover docs
<leader>rn     Rename symbol
<leader>ca     Code action
[d             Previous diagnostic
]d             Next diagnostic
<leader>e      Show diagnostic popup
<leader>dq     Diagnostics to quickfix
<leader>dB     Diagnostics to yankable buffer
<leader>dC     Diagnostics to buffer with code context

Selection / copy
Visual v        Expand smart selection, VS Code Neovim
Visual <leader>y
               Yank selection with file path + line numbers + Markdown fence
<leader>yp     Yank buffer path               


DEEPER REFERENCE

MiniPick picker controls
<CR>           Open selected item
<Esc> / <C-c>  Close picker
<C-n> / Down   Move down
<C-p> / Up     Move up
<C-g> / Home   Move to first match
<Tab>          Toggle preview
<S-Tab>        Toggle info
<C-x>          Mark/unmark item
<C-a>          Mark/unmark all matched items
<M-CR>         Choose/open marked items
<C-s>          Open in horizontal split
<C-v>          Open in vertical split
<C-t>          Open in tab
<C-u>          Delete query left of cursor
<C-w>          Delete previous word in query
<BS>           Delete char left
<Del>          Delete char right
<C-f>          Page/scroll down
<C-b>          Page/scroll up
<C-h>          Scroll left
<C-l>          Scroll right
<C-Space>      Refine current matches
<M-Space>      Refine marked matches

MiniPick search tricks
abc            Fuzzy match abc
'abc           Exact match abc
^abc           Match at start
abc$           Match at end
ab c           Match both ab and c

Mini.diff hunks
gh             Apply/stage hunk(s) in visual/operator region
gH             Reset hunk(s) in visual/operator region
gh             Hunk textobject in operator-pending mode
               Example: ygh = yank current hunk range

Mini.surround
saiw)          Add parentheses around inner word
saiw"          Add quotes around inner word
sd)            Delete surrounding parentheses
sd"            Delete surrounding quotes
sr)"           Replace parentheses with quotes
sf)            Find next surrounding parentheses
sF)            Find previous surrounding parentheses
sh)            Highlight surrounding parentheses
suffix n       Use next surrounding
suffix l       Use previous surrounding
               Example: sdn) = delete next parens
               Example: srl)" = replace previous parens with quotes

Mini.ai textobjects
Use with operators or visual mode:
vaf            Select around function call
vif            Select inside function call
vaa            Select around argument
via            Select inside argument
va) / vi)      Around / inside parentheses
va] / vi]      Around / inside brackets
va} / vi}      Around / inside braces
va" / vi"      Around / inside quotes
vat / vit      Around / inside HTML/XML tag
vaq / viq      Around / inside any quote
vab / vib      Around / inside any bracket
va? / vi?      Prompt-based textobject
g[             Jump to left edge of textobject
g]             Jump to right edge of textobject

Common built-in Neovim keys
:w             Save
:q             Quit
:wq            Save and quit
u              Undo
<C-r>          Redo
/              Search
n              Next search result
N              Previous search result
*              Search word under cursor
%              Jump matching bracket
gg             Top of file
G              Bottom of file
zz             Center cursor line
ciw            Change inner word
diw            Delete inner word
yiw            Yank inner word
ci"            Change inside quotes
ci)            Change inside parentheses
gcc            Not mapped here unless another plugin adds comments

Quickfix
:copen         Open quickfix
:cclose        Close quickfix
:cnext         Next quickfix item
:cprev         Previous quickfix item
