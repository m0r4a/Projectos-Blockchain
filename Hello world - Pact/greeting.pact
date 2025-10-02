(namespace 'free)

(module greeting GOVERNANCE
  "Smart contract que almacena nombres y los saluda"

  (defcap GOVERNANCE ()
    "Governance capability"
    (enforce-keyset "free.admin-keyset"))

  (defschema name-schema
    name:string
    guard:guard)

  (deftable names-table:{name-schema})

  (defun store-name (account:string name:string guard:guard)
    "Almacena el nombre en la tabla"
    (enforce (!= name "") "Name cannot be empty")
    (enforce-guard guard)
    (write names-table account
      { "name": name
      , "guard": guard })
    (format "Name {} stored for account {}" [name account]))

  (defun greet (account:string)
    "Saluda al nombre almacenado"
    (with-read names-table account
      { "name" := name }
      (format "Hola, {}!" [name])))
)
