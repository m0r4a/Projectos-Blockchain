# Greeting Contract - Foundry

Smart contract en Solidity con Foundry que almacena nombres en un mapping y los saluda usando modifiers.

## Requisitos

- Foundry (forge, cast, anvil)

## Instalación de Foundry

```bash
# Opción 1: Desde AUR (Arch Linux)
yay -S foundry-bin

# Opción 2: Instalador oficial
curl -L https://foundry.paradigm.xyz | bash
foundryup
```

Verificar la instalación:
```bash
forge --version
```

## Estructura relevante

```
greet-contract/
├── Makefile
├── src/
│   └── greetingContract.sol
├── test/
│   └── GreetingContract.t.sol
└── foundry.toml
```

## Comandos Make

```bash
make              # Compilar (default)
make build        # Compilar contracts
make test         # Ejecutar tests
make test-v       # Tests con output verbose
make gas          # Tests con reporte de gas
make clean        # Limpiar artifacts
make fmt          # Formatear código Solidity
make node         # Levantar nodo Anvil
make deploy       # Deploy a nodo local
make interact     # Demo interactivo
make help         # Ver todos los comandos
```

## Workflow Completo

### 1. Compilar y testear

```bash
make build
make test
```

### 2. Deploy local

1. Levantar un nodo de Anvil

**Terminal secundaria**
```bash
make node
```

2. Hacer el deploy

**Terminal principal**
```bash
make deploy
```

Guarda la dirección del contrato que aparece en el output.

> Ejemplo: `Deployed to: 0x5FbDB2315678afecb367f032d93F642f64180aa3`

### 3. Interactuar manualmente

```bash
# Exportar dirección del contrato
export CONTRACT=0x5FbDB2315678afecb367f032d93F642f64180aa3

# Guardar nombre
cast send $CONTRACT "storeName(string)" "Astrid" \
  --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 \
  --rpc-url http://127.0.0.1:8545

# Obtener saludo
cast call $CONTRACT "greetMe()" \
  --from 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266 \
  --rpc-url http://127.0.0.1:8545 | cast --to-ascii

# Ver nombre almacenado
cast call $CONTRACT "getName(address)" 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266 \
  --rpc-url http://127.0.0.1:8545 | cast --to-ascii

# Borrar nombre
cast send $CONTRACT "deleteMyName()" \
  --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 \
  --rpc-url http://127.0.0.1:8545
```

### 4. Demo automático

```bash
make interact CONTRACT=0x5FbDB2315678afecb367f032d93F642f64180aa3
```

## Características del Contrato

**Modifiers:**
- `onlyOwner`: Solo el dueño puede ejecutar funciones protegidas
- `hasName`: Verifica que el usuario tenga un nombre almacenado

**Funciones principales:**
- `storeName(string)`: Almacena nombre en el mapping
- `greetMe()`: Retorna saludo personalizado
- `greetAddress(address)`: Saluda a cualquier dirección
- `getName(address)`: Consulta nombre almacenado
- `deleteMyName()`: Elimina tu nombre
- `emergencyReset(address)`: Solo owner, elimina nombre de otros

**Events:**
- `NameStored`: Se emite cuando se guarda un nombre

## Tests

Los tests cubren:
- Owner correcto al deploy
- Almacenar y actualizar nombres
- Events emitidos correctamente
- Validación de nombres vacíos
- Funciones de saludo
- Modifiers (`onlyOwner`, `hasName`)
- Borrar nombres
- Emergency reset
- Múltiples usuarios simultáneos

```bash
# Ejecutar todos los tests
make test

# Tests con logs detallados
make test-v

# Ver gas usage
make gas

# Test específico
forge test --match-test testStoreName -vv
```

## Cuentas de Desarrollo (Anvil)

La primera cuenta que Anvil genera:
- Address: `0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266`
- Private Key: `0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80`

> [!CAUTION]
> Estas llaves son públicas y solo para desarrollo local. **NUNCA** usar en producción.

## Troubleshooting

**Error: "Name not stored"**
- Llama `storeName()` primero antes de `greetMe()`
- Usa `--from` en las llamadas de lectura

**Error: "Dry run enabled"**
- Agrega `--broadcast` al comando `forge create`

**Error: "Only owner can call this function"**
- Solo el deployer puede ejecutar `emergencyReset()`

**Tests fallan**
```bash
make clean
make build
make test
```

## Deploy a Testnet (ES UN POC, NO LO HAGAS)

```bash
# Ejemplo: Sepolia testnet (NO HACER)
forge create src/greetingContract.sol:GreetingContract \
  --rpc-url https://sepolia.infura.io/v3/YOUR_INFURA_KEY \
  --private-key YOUR_PRIVATE_KEY \
  --broadcast
```

> Esto no fue testeado y NO CREO que se deba hacer, pero así se haría

## Recursos

- [Foundry Book](https://book.getfoundry.sh/)
- [Solidity Docs](https://docs.soliditylang.org/)
- [Cast Reference](https://book.getfoundry.sh/reference/cast/)
