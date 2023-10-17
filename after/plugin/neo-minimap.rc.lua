local status, nm = pcall(require, "neo-minimap")
if (not status) then return end

-- TSX
nm.set("zi", "typescriptreact", { -- press `zi` to open the minimap, in `typescriptreact` files
  query = [[
;; query
((function_declaration) @cap) ;; matches function declarations
((arrow_function) @cap) ;; matches arrow functions
((variable_declarator) @cap) ;; matches hooks (useState, useEffect, use***, etc...)
  ]],
})
